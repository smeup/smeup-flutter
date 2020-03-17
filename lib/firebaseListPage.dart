
import 'package:flutter/material.dart';
import 'package:smeup_flutter/customWidgets/firebase/firebaseOnlineStatus.dart';
import 'package:smeup_flutter/homePage.dart';
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/product.dart';
import 'package:smeup_flutter/services/firebaseHttpService.dart';

import 'customWidgets/firebase/firebaseListItem.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'firebaseEditPage.dart';

class FirebaseListPage extends StatefulWidget {

  final String title;
  final bool isFireStore;
  FirebaseListPage({Key key, this.title, this.isFireStore}) : super(key: key);

  @override
  _UserProductsScreen createState() => _UserProductsScreen();
}

class _UserProductsScreen extends State<FirebaseListPage> {
  
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Widget>(
      future: getWidget(),
      builder: (BuildContext context,
          AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: snapshot.data);
          else
            return Center(child: snapshot.data);
        }
      },
    );
  }

  Future<Widget> getWidget() async {
    List<Product> productsData = new List<Product>(); 

    if(widget.isFireStore) {
      HttpProductsResponseSync response = await MyApp.firebaseHttpService.getProductsSync();
        if(!response.isError && response.data != null) {
        productsData = Product.fromMapList(response.data);
      }
    } else {
      HttpProductsResponse response = await MyApp.firebaseHttpService.getProducts();
      if(!response.isError && response.data != 'null') {
        productsData = Product.fromJsonList(response.data);
      }
    }
      
    return Scaffold(
      appBar: AppBar(
        title: MyLabel(
          widget.title,
          18,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirebaseEditPage( new Product(id: null, title: null, description: null, price: 0), widget.isFireStore) ),
              );
            },
          ),
        ],
      ),
      drawer: HomePage(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FirebaseOnlineStatus(
          ListView.builder(
          itemCount: productsData.length,
          itemBuilder: (_, i) => Column(
                children: [
                  FirebaseListItem(
                    productsData[i].id,
                    productsData[i].title,
                    productsData[i].description,
                    productsData[i].price,
                    widget.isFireStore
                  ),
                  Divider()
                ],
              ),
          ),
        ),
      ),
    );

    
  }

}
