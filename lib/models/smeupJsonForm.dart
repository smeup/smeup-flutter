
import 'dart:convert';

import 'package:smeup_flutter/models/smeupJson.dart';
import 'package:smeup_flutter/models/smeupJsonSection.dart';

class SmeupJsonForm extends SmeupJson {
  String type;
  String title;
  String layout;
  String id;
  bool loaded;
  String fun;
  List<SmeupJsonSection> sections;

  SmeupJsonForm.fromJson(response) {

    Map<String, dynamic> jsonMap = json.decode(response);
    type = jsonMap['type'];
    title = jsonMap['title'];
    layout = jsonMap['layout'];
    id = jsonMap['id'];
    loaded = jsonMap['loaded'];
    fun = jsonMap['fun'];

    sections = getSections(jsonMap, 'sections');
  }

  Map<String, dynamic> toJson() =>
    {
      'type': type,
      'title': title,
      'layout': layout,
      'id': id,
      'loaded': loaded,
      'sections': sections,
      'fun': fun,
    };

  bool hasSections() {
    return sections != null && sections.length > 0;
  }

}
