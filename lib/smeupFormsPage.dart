import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myBottomBar.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myLabel.dart';
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/smeupBottomBarSettings.dart';
import 'package:smeup_flutter/models/smeupJsonForms.dart';
import 'package:smeup_flutter/smeupFormPage.dart';

import 'customWidgets/wrappers/myButton.dart';
import 'models/smeupWidgetBuilderResponse.dart';

class SmeupFormsPage extends StatefulWidget {
  final String title;
  final String listName;
  final bool isOffline;

  SmeupFormsPage({Key key, this.title, this.listName, this.isOffline}) : super(key: key);

  @override
  _SmeupFormsPageState createState() => _SmeupFormsPageState();
}

class _SmeupFormsPageState extends State<SmeupFormsPage> {
  var smeupHttpService = MyApp.smeupHttpService;

  @override
  void initState() {
    super.initState();

    MyApp.smeupSettings.offlineEnabled = widget.isOffline;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getFormsList(widget.listName),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else
            return Center(child: snapshot.data.children);
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> getFormsList(String listName) async {
    if (listName == null || listName.isEmpty) {
      return SmeupWidgetBuilderResponse(
          null,
          new Text(
              'It was not possibile to get the list of the scripts: $listName'));
    }

    return smeupHttpService.getScript(listName).then((response) {

      if(response.isError)
        return SmeupWidgetBuilderResponse(null, new Text(response.data));

      var smeupJsonForms = SmeupJsonForms.fromJson(response.data);

      if (smeupJsonForms.formsList.length == 0)
        return SmeupWidgetBuilderResponse(
            null, new Text('the list of the scripts is empty: $listName'));

      // List<Widget> widgetsList = List<Widget>();
      // widgetsList.add(const MyLabel('Select the SmeUp component to test', 18));

      // smeupJsonForms.formsList.forEach((f) {
      //   widgetsList.add(
      //     MyButton(f, () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => SmeupFormPage(f)),
      //       );
      //     }),
      //   );
      // });

      List<Widget> widgetsList = [
        MyLabel('Select the SmeUp component to test', 18),
        ...smeupJsonForms.formsList.map( (f) {
            return MyButton(f, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SmeupFormPage(f)),
            );
          });
        })
      ];

      

      Widget children = Scaffold(
        appBar: AppBar(
          title: MyLabel(
            widget.title,
            18,
          ),
        ),
        body: SingleChildScrollView(
                    child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: widgetsList,
          ),
        ),
        bottomNavigationBar: MyBottomBar(
            SmeupBottomBarSettings(refreshData: true, settings: true)),
      );

      return SmeupWidgetBuilderResponse(smeupJsonForms, children);
    });
  }
}
