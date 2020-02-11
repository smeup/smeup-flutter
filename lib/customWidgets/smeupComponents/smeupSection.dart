import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupComponent.dart';
import 'package:smeup_flutter/models/smeupJsonSection.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';

class SmeupSection extends StatefulWidget {
  
  final SmeupJsonSection smeupJsonSection;

  SmeupSection(this.smeupJsonSection);

  @override
  _SmeupSectionState createState() => _SmeupSectionState();
}

class _SmeupSectionState extends State<SmeupSection> {
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getSectionChildren(widget.smeupJsonSection), 
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

  Future<SmeupWidgetBuilderResponse> getSectionChildren(SmeupJsonSection smeupJsonSection) async {

    if (!smeupJsonSection.hasSections() && !smeupJsonSection.hasComponents()) {
      return SmeupWidgetBuilderResponse(
                smeupJsonSection,
                new Text(
                    'The section has not either sections nor components in it. ScriptName: Text: $smeupJsonSection'));
    }

    Widget children;

    if (smeupJsonSection.hasSections()) {
      var sections = List<SmeupSection>();
       
      smeupJsonSection.sections.forEach( (s) {
        var section = SmeupSection(s); 
        sections.add(section);
      });

      if(smeupJsonSection.layout == "column" ){
        children = Column(children: sections);
      }
      else {
        children = Row(children: sections);
      }
    }
    
    if (smeupJsonSection.hasComponents()) {
      var components = List<SmeupComponent>();
       
      smeupJsonSection.components.forEach( (c) {
        var component = SmeupComponent(c); 
        components.add(component);
      });

      if(smeupJsonSection.layout == "column" ){
        children = Column(children: components);
      }
      else {
        children = Row(children: components);
      }
    }

    return SmeupWidgetBuilderResponse(smeupJsonSection, children);
  }

}
