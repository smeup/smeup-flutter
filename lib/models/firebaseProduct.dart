import 'package:flutter/foundation.dart';
import 'dart:convert';

class FirebaseProduct with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  bool isFavorite;

  FirebaseProduct({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  static List<FirebaseProduct> fromJsonList(String data) {
    List<FirebaseProduct> productsData = new List<FirebaseProduct>(); 
      Map<String, dynamic> map = jsonDecode(data);
      map.forEach((key, value) {
        FirebaseProduct fp = new FirebaseProduct(id: key, description: value["description"], price: value["price"], isFavorite: value["isFavorite"], title: value["title"] );
        productsData.add(fp);
      });
      return productsData;
  }

  static String toJson(FirebaseProduct product) {
    return json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'isFavorite': product.isFavorite,
    });
  }
}
