class SmeupChartColumn {
  String name;
  String title;
  String size;

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);
  
  SmeupChartColumn.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['name'];
    title = jsonMap['title'];
    size = jsonMap['size'];
  }
}