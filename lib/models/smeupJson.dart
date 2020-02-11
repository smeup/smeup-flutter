import 'smeupJsonComponent.dart';
import 'smeupJsonSection.dart';

abstract class SmeupJson {
  List<SmeupJsonSection> getSections(jsonMap, sectionName) {
    var sections = new List<SmeupJsonSection>();
    List<dynamic> sectionsJson;

    if (jsonMap is Map && jsonMap.containsKey(sectionName))
      sectionsJson = jsonMap[sectionName];
    else if (sectionName == "_sections_")
      sectionsJson = jsonMap;

    if (sectionsJson != null)
      sectionsJson.forEach((v) {
        SmeupJsonSection smeupSection = SmeupJsonSection.fromJson(v);
        sections.add(smeupSection);
      });

    return sections;
  }

  List<SmeupJsonComponent> getComponents(jsonMap, componentName) {
    var components = new List<SmeupJsonComponent>();

    if (jsonMap.containsKey(componentName)) {
      List<dynamic> componentsJson = jsonMap[componentName];
      componentsJson.forEach((v) {
        SmeupJsonComponent smeupComponent = SmeupJsonComponent.fromJson(v);
        components.add(smeupComponent);
      });
    }

    return components;
  }
}
