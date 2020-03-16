import 'package:flutter/material.dart';
import 'package:smeup_flutter/firebaseEditPage.dart';
import 'package:smeup_flutter/models/product.dart';

import '../../firebaseListPage.dart';
import '../../main.dart';

class FirebaseListItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final double price;
  final bool isFireStore;

  FirebaseListItem(this.id, this.title, this.description, this.price, this.isFireStore);

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
                          builder: (context) => FirebaseEditPage( Product(title: title, id: id, description: description, price: price), isFireStore )),
                    ); 
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                
                if(isFireStore) {
                  MyApp.firebaseHttpService.deleteProductsSync(Product(title: title, id: id, description: description, price: price)).then((_) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Firebase ONLINE')));
                  });
                } else {
                  MyApp.firebaseHttpService.deleteProducts(Product(title: title, id: id, description: description, price: price)).then((_) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Firebase OFFLINE')));
                  });
                }
                
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
