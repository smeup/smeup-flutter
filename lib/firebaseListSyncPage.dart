
import 'package:flutter/material.dart';
import 'package:smeup_flutter/homePage.dart';
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/product.dart';
import 'package:smeup_flutter/services/firebaseHttpService.dart';

import 'customWidgets/firebase/firebaseListItemSync.dart';
import 'customWidgets/wrappers/myLabel.dart';
import 'firebaseEditSyncPage.dart';

class FirebaseListSyncPage extends StatefulWidget {

  final String title;
  FirebaseListSyncPage({Key key, this.title}) : super(key: key);

  @override
  _UserProductsScreen createState() => _UserProductsScreen();
}

class _UserProductsScreen extends State<FirebaseListSyncPage> {
  
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
    HttpProductsResponseSync response = await MyApp.firebaseHttpService.getProductsSync();
    
    List<Product> productsData = new List<Product>(); 
    
    if(!response.isError && response.data != null) {
      productsData = Product.fromMapList(response.data);
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
                        builder: (context) => FirebaseEditSyncPage( new Product(id: null, title: null, description: null, price: 0) )),
                  );
            },
          ),
        ],
      ),
      drawer: HomePage(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.length,
          itemBuilder: (_, i) => Column(
                children: [
                  FirebaseListItemSync(
                    productsData[i].id,
                    productsData[i].title,
                    productsData[i].description,
                    productsData[i].price,
                  ),
                  Divider(),
                ],
              ),
        ),
      ),
    );

    
  }

}
