import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import '../../customWidgets/smeupComponents/smeupChart.dart';
import '../../customWidgets/smeupComponents/smeupForm.dart';
import '../../customWidgets/smeupComponents/smeupLabel.dart';
import '../../customWidgets/smeupComponents/smeupSection.dart';
import '../../main.dart';
import '../../models/smeupJsonForm.dart';
import '../../models/smeupWidgetBuilderResponse.dart';
import '../../models/smeupJsonComponent.dart';


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
          
          return Center(child: const Text('Please wait its loading...'));

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

                double kMinWidthOfLargeScreen = 400;
                bool isScreenWide = MediaQuery.of(context).size.width >= kMinWidthOfLargeScreen;
                
              
                List<dynamic> smeupJsonForms = json.decode(response.data);
                var forms = List<SmeupForm>();

                smeupJsonForms.forEach((f) {
                  var smeupJsonForm = SmeupJsonForm.fromJson(json.encode(f));
                  forms.add(SmeupForm(smeupJsonForm));
                });
                
                // if(smeupJsonComponent.layout == "column" ){
                //   children = SingleChildScrollView(child: Column(children: forms), scrollDirection: Axis.horizontal);
                // }
                // else {
                //   children = SingleChildScrollView(child: Row(children: forms), scrollDirection: Axis.vertical, );
                // }

                children = Flex(direction: isScreenWide ? Axis.horizontal: Axis.vertical, children: forms, );
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
