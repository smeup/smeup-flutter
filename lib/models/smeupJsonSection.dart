import '../models/smeupJson.dart';
import '../models/smeupJsonComponent.dart';

class SmeupJsonSection extends SmeupJson {

  String layout;
  String id;
  String dim;
  int size;
  List<SmeupJsonComponent> components;
  List<SmeupJsonSection> sections;

  SmeupJsonSection(this.components);

  SmeupJsonSection.fromJson(Map<String, dynamic> jsonMap) {

    layout = jsonMap['layout'];
    id = jsonMap['id'];
    dim = jsonMap['dim'];
    size = jsonMap['size'];
    components = getComponents(jsonMap, 'components');
    sections = getSections(jsonMap, 'sections');

  }
  
  bool hasSections() {
    return sections != null && sections.length > 0;
  }

  bool hasComponents() {
    return components != null && components.length > 0;
  }

}