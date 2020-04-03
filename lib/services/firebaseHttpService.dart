import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../models/product.dart';

class HttpProductsResponse {
  String data;
  bool isError;
  HttpProductsResponse(this.data, this.isError);
}

class HttpProductsResponseSync {
  QuerySnapshot data;
  bool isError;

  HttpProductsResponseSync(this.data, this.isError);
}

class FirebaseHttpService {

  /// ONLINE METHODS
  /// 
  Future<HttpProductsResponse> getProducts() async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products.json';
    return http.get(url).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200);
    }).catchError((e) {
      return HttpProductsResponse(null, true);
    });
  }

  Future<HttpProductsResponse> postProducts(Product product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products.json';
    return http
        .post(url, body: Product.toJson(product))
        .then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200);
    });
  }

  Future<HttpProductsResponse> patchProducts(Product product) async {
    String url =
        MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http
        .patch(url, body: Product.toJson(product))
        .then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200);
    });
  }

  Future<HttpProductsResponse> deleteProducts(Product product) async {
    String url =
        MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http.delete(url).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200);
    });
  }

  /// OFFLINE METHODS
  /// 

  Future<Source> getSource() async {
    bool onValue = await MyApp.isOnline();
      if(onValue)
        return Source.server; 
      else  
        return Source.cache;
  } 
  

  Future<HttpProductsResponseSync> getProductsSync() async {
    QuerySnapshot snapshot;
    try {
      snapshot = await MyApp.fsCloudDb
        .collection("products")
        .getDocuments(source: await getSource());  
    } catch (e) {
      print(e);
    }
    return HttpProductsResponseSync(snapshot, false);
  }

  Future<HttpProductsResponseSync> postProductsSync(Product product) async {

    try {
      // do not await because it's going to hang!!!
      // await MyApp.fsCloudDb
      MyApp.fsCloudDb
          .collection('products')
          .add(product.toMap());  
    } catch (e) {
      print(e);
    }
    
    return HttpProductsResponseSync(null, false);
  }

  Future<HttpProductsResponseSync> deleteProductsSync(Product product) async {

    try {
      MyApp.fsCloudDb
          .collection('products')
          .document(product.id)
          .delete();  
    } catch (e) {
      print(e);
    }
    
    return HttpProductsResponseSync(null, false);
  }

  Future<HttpProductsResponseSync> patchProductsSync(Product product) async {

    try {
      MyApp.fsCloudDb
        .collection('products')
        .document(product.id)
        .updateData(product.toMap());  
    } catch (e) {
      print(e);
    }
    
    return HttpProductsResponseSync(null, false);
  }

}
