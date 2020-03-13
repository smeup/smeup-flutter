import 'package:flutter/material.dart';
import 'package:smeup_flutter/firebaseEditPage.dart';
import 'package:smeup_flutter/models/firebaseProduct.dart';

import '../../firebaseListPage.dart';
import '../../main.dart';

class FirebaseListItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final double price;
  

  FirebaseListItem(this.id, this.title, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirebaseEditPage( FirebaseProduct(title: title, id: id, description: description, price: price) )),
                  );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                //Provider.of<Products>(context, listen: false).deleteProduct(id);
                MyApp.firebaseHttpService.deleteProducts(FirebaseProduct(title: title, id: id, description: description, price: price)).then((_) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Smeup Flutter - Firebase CRUD')));
                });
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
