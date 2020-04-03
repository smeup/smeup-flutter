import 'package:flutter/material.dart';

import '../../firebaseEditPage.dart';
import '../../models/product.dart';
import '../../firebaseListPage.dart';
import '../../main.dart';

class FirebaseListItem extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final double price;
  final bool isFireStore;
  final Function callBack;
  FirebaseListItem(this.id, this.title, this.description, this.price, this.isFireStore, this.callBack);

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

                // Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => FirebaseEditPage( Product(title: title, id: id, description: description, price: price), isFireStore, null )),
                //     ); 
                showModalBottomSheet(context: context, builder: (_) { 
                  return FirebaseEditPage( Product(title: title, id: id, description: description, price: price), isFireStore, callBack );
                });

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
                            title: 'Firebase ONLINE',
                            isFireStore: isFireStore,)));
                    callBack();
                  });
                } else {
                  MyApp.firebaseHttpService.deleteProducts(Product(title: title, id: id, description: description, price: price)).then((_) {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => FirebaseListPage(
                            title: 'Firebase OFFLINE',
                            isFireStore: isFireStore,)));
                    callBack();
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
