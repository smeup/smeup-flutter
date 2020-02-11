
import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupForm.dart';
import 'package:smeup_flutter/models/smeupJsonForm.dart';
import 'package:smeup_flutter/models/smeupJsonRoot.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';
import '../../main.dart';

class SmeupRoot extends StatefulWidget {
  final String scriptName;

  SmeupRoot(this.scriptName);

  @override
  _SmeupRootState createState() => _SmeupRootState();
}

class _SmeupRootState extends State<SmeupRoot> {

  var smeupHttpService = MyApp.smeupHttpService;

  @override
  Widget build(BuildContext context) {
    var smeupJsonRoot = new SmeupJsonRoot();
    smeupJsonRoot.fun = widget.scriptName;

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getRootChildren(smeupJsonRoot), 
      builder: (BuildContext context, AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {             
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Center(child: snapshot.data.children);                                    
        }
      },
    );
    
  }

  Future<SmeupWidgetBuilderResponse> getRootChildren(SmeupJsonRoot smeupJsonRoot) async {

    if (smeupJsonRoot.fun == null || smeupJsonRoot.fun.isEmpty) {
      return SmeupWidgetBuilderResponse(
          smeupJsonRoot,
          new Text(
              'It was not possibile to get the text of the script: $smeupJsonRoot'));
    }

      
    return smeupHttpService.getScript((smeupJsonRoot).fun).then((response) {

      var smeupJsonForm = SmeupJsonForm.fromJson(response.data);

      if(smeupJsonForm.type != "EXD") {
        return SmeupWidgetBuilderResponse(
              smeupJsonForm,
              new Text(
                  'The root must be of type EXD. ScriptName: $smeupJsonRoot. Text: ${response.data}'));
      }

      var smeupForm = SmeupForm(smeupJsonForm);

      Widget children; 
      if(smeupJsonForm.layout == "column" )
        children = Column(children: <Widget>[smeupForm],);
      else 
        children = Row(children: <Widget>[smeupForm],);

      return SmeupWidgetBuilderResponse(smeupJsonRoot, children);
      
    });

  }

}
