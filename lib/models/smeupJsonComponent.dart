import '../models/smeupJson.dart';
import '../models/smeupJsonSection.dart';

class SmeupJsonComponent extends SmeupJson {
  String type;
  String title;
  String layout;
  String id;
  bool loaded;
  String fun;
  dynamic options;
  dynamic data;
  List<SmeupJsonSection> sections;

  SmeupJsonComponent.fromJson(Map<String, dynamic> jsonMap) {

    type = jsonMap['type'];
    title = jsonMap['title'];
    layout = jsonMap['layout'];
    id = jsonMap['id'];
    loaded = jsonMap['loaded'];
    fun = jsonMap['fun'];
    options = jsonMap['options'];
    data = jsonMap['data'];

    sections = this.sections = getSections(jsonMap, 'sections');

  }

  bool hasSections() {
    return sections != null && sections.length > 0;
  }

  bool hasData() {
    return data != null;
  }

}
