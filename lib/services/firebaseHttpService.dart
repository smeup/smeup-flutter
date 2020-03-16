
import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/product.dart';
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

  Future<HttpProductsResponse> postProducts(Product product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products.json';
    return http.post(url, body: Product.toJson(product)).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

  Future<HttpProductsResponse> patchProducts(Product product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http.patch(url, body: Product.toJson(product)).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

  Future<HttpProductsResponse> deleteProducts(Product product) async {
    String url = MyApp.smeupSettings.firebaseUrl + 'products/${product.id}.json';
    return http.delete(url).then((http.Response response) {
      return HttpProductsResponse(response.body, response.statusCode != 200); 
    });
  }

}
