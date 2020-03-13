
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/firebaseProduct.dart';
import 'package:http/http.dart' as http;

class HttpProductsResponse {
  String data;
  bool isError;

  HttpProductsResponse(this.data, this.isError);
}

class FirebaseHttpService {

  Future<HttpProductsResponse> getProducts() async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products.json';
    return http.get(url)
    .then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200);
      }).catchError((e) {
      return HttpProductsResponse(null, true);
    });
  }

  Future<HttpProductsResponse> postProducts(FirebaseProduct product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products.json';
    return http.post(url, body: FirebaseProduct.toJson(product)).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

  Future<HttpProductsResponse> patchProducts(FirebaseProduct product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http.patch(url, body: FirebaseProduct.toJson(product)).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

  Future<HttpProductsResponse> deleteProducts(FirebaseProduct product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http.delete(url).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

}
