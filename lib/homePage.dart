import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/wrappers/myCustomButton.dart';
import 'package:smeup_flutter/smeupFormsPage.dart';
import 'package:smeup_flutter/utilitiesPage.dart';

import 'customWidgets/wrappers/myBottomBar.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'firebaseListPage.dart';
import 'models/smeupBottomBarSettings.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyLabel(
          widget.title,
          18,
        ),
      ),
      body: SingleChildScrollView(
                child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            MyCustomButton(
                buttonText: 'SMEUP FORMS ONLINE',
                buttonClickHandler: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SmeupFormsPage(
                            title: 'Smeup Flutter - Forms Page',
                            listName: 'servicesList',
                            isOffline: false,)),
                  );
                },
                strokeColor: Colors.yellow,
                strokeWidth: 50,
                paintingStyle: PaintingStyle.fill),

            MyCustomButton(
                buttonText: 'SMEUP FORMS OFFLINE',
                buttonClickHandler: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SmeupFormsPage(
                            title: 'Smeup Flutter - Forms Page',
                            listName: 'servicesList',
                            isOffline: true,)),
                  );
                },
                strokeColor: Colors.yellow,
                strokeWidth: 50,
                paintingStyle: PaintingStyle.fill),

            MyCustomButton(
                buttonText: 'UTILITIES',
                buttonClickHandler: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UtilitiesPage(
                            title: 'Smeup Flutter - Utilities Page')),
                  );
                },
                strokeColor: Colors.blue,
                strokeWidth: 50,
                paintingStyle: PaintingStyle.fill),

            MyCustomButton(
                buttonText: 'FIREBASE ONLINE',
                buttonClickHandler: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Firebase ONLINE',
                            isFireStore: false,)),
                  );
                },
                strokeColor: Colors.green,
                strokeWidth: 50,
                paintingStyle: PaintingStyle.fill),

            MyCustomButton(
                buttonText: 'FIREBASE OFFLINE',
                buttonClickHandler: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Firebase OFFLINE',
                            isFireStore: true)),
                  );
                },
                strokeColor: Colors.green,
                strokeWidth: 50,
                paintingStyle: PaintingStyle.fill),

          ],
        ),
      ),
      bottomNavigationBar: MyBottomBar(
          SmeupBottomBarSettings(refreshData: true, settings: true)),
    );
  }
}
