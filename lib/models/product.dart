import 'package:flutter/foundation.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  bool isFavorite;

  Product({
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

  static List<Product> fromJsonList(String data) {
    List<Product> productsData = new List<Product>(); 
      Map<String, dynamic> map = jsonDecode(data);
      map.forEach((key, value) {
        Product fp = new Product(id: key, description: value["description"], price: value["price"], isFavorite: value["isFavorite"], title: value["title"] );
        productsData.add(fp);
      });
      return productsData;
  }

  static String toJson(Product product) {
    return json.encode({
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'isFavorite': product.isFavorite,
    });
  }
}
