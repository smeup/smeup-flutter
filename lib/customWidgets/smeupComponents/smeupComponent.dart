import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupChart.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupForm.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupLabel.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupSection.dart';
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/smeupJsonForm.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';
import 'package:smeup_flutter/models/smeupJsonComponent.dart';


class SmeupComponent extends StatefulWidget {
  
  final SmeupJsonComponent smeupJsonComponent;

  SmeupComponent(this.smeupJsonComponent);

  @override
  _SmeupComponentState createState() => _SmeupComponentState();
}

class _SmeupComponentState extends State<SmeupComponent> {

  var smeupHttpService = MyApp.smeupHttpService;

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getComponentChildren(widget.smeupJsonComponent), 
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

  Future<SmeupWidgetBuilderResponse> getComponentChildren(SmeupJsonComponent smeupJsonComponent) async {


    var children;

    if (smeupJsonComponent.hasSections()) {
      var sections = List<SmeupSection>();
       
      smeupJsonComponent.sections.forEach( (s) {
        var section = SmeupSection(s); 
        sections.add(section);
      });

      if(smeupJsonComponent.layout == "column" ){
        children = Column(children: sections);
      }
      else {
        children = Row(children: sections);
      }
    }
    else {
        switch (smeupJsonComponent.type) {
          case "LAB":
            children = SmeupLabel(smeupJsonComponent);
            break;
          case "CHA":
            children = SmeupChart(smeupJsonComponent);
            break;
          case "MAT":
            children = getMatrixComponent(smeupJsonComponent);
            break;
          case "DSH":
            children = getDashboardComponent(smeupJsonComponent);
            break;
          case "EXD":
            await smeupHttpService.getScript(smeupJsonComponent.fun).then((response) {

              if (response.isError)
                  children =  Text(response.data);
              else {
              
                List<dynamic> smeupJsonForms = json.decode(response.data);
                var forms = List<SmeupForm>();

                smeupJsonForms.forEach((f) {
                  var smeupJsonForm = SmeupJsonForm.fromJson(json.encode(f));
                  forms.add(SmeupForm(smeupJsonForm));
                });
                
                if(smeupJsonComponent.layout == "column" ){
                  children = Column(children: forms);
                }
                else {
                  children = Row(children: forms);
                }
              }
            });
            break;                                    
          default:
        }
    }
    
    return SmeupWidgetBuilderResponse(smeupJsonComponent, children);
  }

  

  Widget getMatrixComponent(SmeupJsonComponent smeupJsonComponent) {

    return new Text('I\'am a ${smeupJsonComponent.type} component');

  }

  Widget getDashboardComponent(SmeupJsonComponent smeupJsonComponent) {

    return new Text('I\'am a ${smeupJsonComponent.type} component');

  }

  Widget getFormComponent(SmeupJsonComponent smeupJsonComponent) {

    return new Text('I\'am a ${smeupJsonComponent.type} component');

  }

}
