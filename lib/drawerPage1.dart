import 'package:flutter/material.dart';

import 'customWidgets/wrappers/mainDrawer.dart';

class DrawerPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('drawerPage1'),
      ),
      drawer: MainDrawer(),
      body: Center(child: Text('ciao'),)
        ,

    );
  }
}