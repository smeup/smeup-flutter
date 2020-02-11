import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/smeupComponents/smeupRoot.dart';

import 'customWidgets/wrappers/myBottomBar.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'models/smeupBottomBarSettings.dart';

class SmeupFormPage extends StatelessWidget {
  final String scriptName;

  SmeupFormPage(this.scriptName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyLabel(scriptName, 18),
      ),
      body: Center(
        child: SmeupRoot(scriptName),
      ),
      bottomNavigationBar: MyBottomBar(SmeupBottomBarSettings(home: true, settings: true, refreshData: true)),
    );
  }
}
