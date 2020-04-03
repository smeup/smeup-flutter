import 'dart:convert';

import '../models/smeupJson.dart';

class SmeupJsonForms extends SmeupJson {
  String fun;

  List<String> formsList;

  SmeupJsonForms.fromJson(response) {
    formsList = List<String>();

    List<dynamic> scripts = json.decode(response);
    scripts.forEach((f) {
      formsList.add(f["name"]);
    });
    
  }
}
