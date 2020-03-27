import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupSection.dart';
import 'package:smeup_flutter/models/smeupJsonForm.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';
import 'package:smeup_flutter/services/smeupHttpService.dart';

import '../../main.dart';

class SmeupForm extends StatefulWidget {
  
  final SmeupJsonForm smeupJsonForm;

  SmeupForm(this.smeupJsonForm);

  @override
  _SmeupFormState createState() => _SmeupFormState();
}

class _SmeupFormState extends State<SmeupForm> {

  var smeupHttpService = MyApp.smeupHttpService;

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getFormChildren(widget.smeupJsonForm), 
      builder: (BuildContext context, AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          
          return Center(child: Text('Please wait its loading...'));

        } else {

          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
             return Center(child: snapshot.data.children);
          }
        }
      },
    );

  }

  Future<SmeupWidgetBuilderResponse> getFormChildren(SmeupJsonForm smeupJsonForm) async {

    if (smeupJsonForm.fun != null && smeupJsonForm.fun.isNotEmpty) {

      HttpScriptResponse response = await smeupHttpService.getScript(smeupJsonForm.fun);
      
      if (response.isError)
        return SmeupWidgetBuilderResponse(
              smeupJsonForm, new Text(response.data));

      var script = response.data;
      smeupJsonForm.sections = smeupJsonForm.getSections(json.decode(script), '_sections_');
    } 

    if(smeupJsonForm.type != null && smeupJsonForm.type != "EXD") {
      return SmeupWidgetBuilderResponse(
                smeupJsonForm,
                new Text(
                    'The form must be of type EXD. ScriptName: Text: $smeupJsonForm'));
    }

    if (!smeupJsonForm.hasSections()) {
      return SmeupWidgetBuilderResponse(
                smeupJsonForm,
                new Text(
                    'The form has no sections in it. ScriptName: Text: $smeupJsonForm'));
    }

    Widget children;
    var sections = List<SmeupSection>();
    
    smeupJsonForm.sections.forEach( (s) {
      var section = SmeupSection(s); 
      sections.add(section);
    });

    if(smeupJsonForm.layout == "column" ){
      children = SingleChildScrollView(child: Column(children: sections), scrollDirection: Axis.horizontal, );
    }
    else {
      children = SingleChildScrollView(child: Row(children: sections), scrollDirection: Axis.vertical, );
    }
    
    return SmeupWidgetBuilderResponse(smeupJsonForm, children);
  }
}
