import 'package:flutter/material.dart';
import 'package:smeup_flutter/models/smeupJsonComponent.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';

class SmeupLabel extends StatefulWidget {
  final SmeupJsonComponent smeupJsonComponent;

  SmeupLabel(this.smeupJsonComponent);

  @override
  _SmeupLabelState createState() => _SmeupLabelState();
}

class _SmeupLabelState extends State<SmeupLabel> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getLabelComponent(widget.smeupJsonComponent),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
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

  Future<SmeupWidgetBuilderResponse> getLabelComponent(
      SmeupJsonComponent smeupJsonComponent) async {
    Widget children;
    List<Text> labels = List<Text>();
    if (smeupJsonComponent.hasData()) {
      (smeupJsonComponent.data as List).forEach((l) {
        var map = (l as Map);
        var label = Text(map["value"]);
        labels.add(label);
      });

      if (labels.length > 0) {
        children = Column(children: labels);
        return SmeupWidgetBuilderResponse(smeupJsonComponent, children);
      }
    }

    return SmeupWidgetBuilderResponse(smeupJsonComponent,
        new Text('I\'am an empty ${smeupJsonComponent.type} component'));
  }
}
