import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';

import 'customWidgets/wrappers/myBottomBar.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'models/smeupBottomBarSettings.dart';

class ApplicationInteractionsPage extends StatefulWidget {
  ApplicationInteractionsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ApplicationInteractionsPageState createState() => _ApplicationInteractionsPageState();
}
 
class _ApplicationInteractionsPageState extends State<ApplicationInteractionsPage> {

  @override
  Widget build(BuildContext context) {
    if (installedApps == null)
      getApps();

    return Scaffold(
      appBar: AppBar(

        title: MyLabel(
          widget.title,
          18,
        ),
      ),
      body: ListView.builder(
          itemCount: installedApps == null ? 0 : installedApps.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(installedApps[index]["app_name"]),
              trailing: IconButton(
                icon: const Icon(Icons.open_in_new),
                onPressed: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  AppAvailability.launchApp(installedApps[index]["package_name"]).then((_) {
                    print("App ${installedApps[index]["app_name"]} launched!");
                  }).catchError((err) {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("App ${installedApps[index]["app_name"]} not found!")
                    ));
                    print(err);
                  });
                }
              ),
            );
          },
        ),
      
      bottomNavigationBar: MyBottomBar(SmeupBottomBarSettings(refreshData: true, settings: true)),

    );
  }

List<Map<String, String>> installedApps;
  List<Map<String, String>> iOSApps = [
    {
      "app_name": "Calendar",
      "package_name": "calshow://"
    },
    {
      "app_name": "Facebook",
      "package_name": "fb://"
    },
    {
      "app_name": "Whatsapp",
      "package_name": "whatsapp://"
    }
  ];


  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getApps() async {
    List<Map<String, String>> _installedApps;

    if (Platform.isAndroid) {

      _installedApps = await AppAvailability.getInstalledApps();

      print(await AppAvailability.checkAvailability("com.android.chrome"));
      // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

      print(await AppAvailability.isAppEnabled("com.android.chrome"));
      // Returns: true

    }
    else if (Platform.isIOS) {
      // iOS doesn't allow to get installed apps.
      _installedApps = iOSApps;

      print(await AppAvailability.checkAvailability("calshow://"));
      // Returns: Map<String, String>{app_name: , package_name: calshow://, versionCode: , version_name: }

    }

    setState(() {
      installedApps = _installedApps;
    });

  }

}