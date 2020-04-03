import 'package:flutter/material.dart';

import '../../models/smeupBottomBarSettings.dart';

class MyBottomBar extends StatefulWidget {
  final SmeupBottomBarSettings barSettings;

  MyBottomBar(this.barSettings);

  @override
  _MyBottomBarState createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {

  List<BottomNavigationBarItem> list;


  @override
  Widget build(BuildContext context) {
    
    list = List<BottomNavigationBarItem>();

    if(widget.barSettings.home)
      list.add( BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: const Text('Home'),
            ));

    if(widget.barSettings.settings)
      list.add( BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: const Text('Settings'),
            ));

    if(widget.barSettings.refreshData)
      list.add( BottomNavigationBarItem(
              icon: Icon(Icons.refresh),
              title: const Text('RefreshData'),
            ));

    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: BottomNavigationBar(
          items: list,
        ));
  }
}
