import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
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

  static List<Product> fromMapList(QuerySnapshot snapshot) {
    List<Product> products = new List<Product>();
    List<DocumentSnapshot> documents = snapshot.documents;
    documents.forEach( (document) {
        Product product = Product(id: document.documentID, title: document.data['title'], description: document.data['description'], price: document.data['price'], isFavorite: document.data['isFavorite']);
        products.add(product);
    });
    return products;
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'isFavorite': this.isFavorite
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

}
