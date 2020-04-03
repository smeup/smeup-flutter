import 'package:flutter/material.dart';
import 'package:smeup_flutter/drawerPage1.dart';

import '../../homePage.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(children: <Widget>[
        Container(child: Text('Links'),),
        SizedBox(height: 20,),
        Container(child: ListTile( leading: Icon(Icons.access_alarm), title: Text('home'), onTap: () {

          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(key: null,
                            title: 'Smeup Flutter - Home Page')),
                  );

         } ,),),
        Container(child: ListTile( leading: Icon(Icons.settings), title: Text('pag1'), onTap: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DrawerPage1(),
                  ));

         } ,),),
      ],) );
  }
}