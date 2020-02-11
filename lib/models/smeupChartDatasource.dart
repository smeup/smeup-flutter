
import 'dart:convert';

import 'package:smeup_flutter/models/smeupChartColumn.dart';
import 'package:smeup_flutter/models/smeupChartRow.dart';
import 'package:smeup_flutter/models/smeupJsonComponent.dart';


class SmeupChartDatasource {
  List<SmeupChartColumn> columns;
  List<SmeupChartRow> rows;
  String chartType;
  int refreshMilliseconds = -1;
  
  SmeupChartDatasource.fromJson(SmeupJsonComponent smeupJsonComponent, String script) {
   
   setOptions(smeupJsonComponent);

    Map<String, dynamic> jsonData = json.decode(script);

    columns = List<SmeupChartColumn>();
    jsonData['columns'].forEach(
      (c) => columns.add(SmeupChartColumn.fromJson(c)) 
    ); 

    rows = List<SmeupChartRow>();
    jsonData['rows'].forEach(
      (r) => rows.add(SmeupChartRow.fromJson(r, columns)) 
    );   
  }

  SmeupChartDatasource.fromInfluxDB(SmeupJsonComponent smeupJsonComponent, String script) {
   
   setOptions(smeupJsonComponent);
   
    Map<String, dynamic> jsonMap =json.decode(script);
    List<dynamic> jsonResults = jsonMap['results'];    
    var jsonResult = jsonResults[0];
    List<dynamic> jsonSeries = jsonResult["series"];
    var jsonData = jsonSeries[0];
    List<dynamic> jsonColumns = jsonData["columns"];
    List<dynamic> jsonValues = jsonData["values"];

    columns = List<SmeupChartColumn>();
    jsonColumns.forEach((c) {
      columns.add(SmeupChartColumn.fromInfluxDB(c, c, ''));
    });

    rows = List<SmeupChartRow>();
    jsonValues.forEach((r) {
      rows.add(SmeupChartRow.fromInfluxDB(r, columns));
    });
    
    print(jsonData);
  }

  List<SmeupGraphData> getDataTable(int xCol, int yCol, int filterCol, Function filterFunction, String filterValue) {

    List<SmeupGraphData> datatable;
    datatable = List<SmeupGraphData>();
    
    rows.forEach((f) {
      double x = 0;
      if (f.cells[xCol] is double)
        x = f.cells[xCol];
      else 
        x = double.parse(f.cells[xCol].toString());

      double y = 0;
      if (f.cells[yCol] is double)
        y = f.cells[yCol];
      else 
        y = double.parse(f.cells[yCol].toString());

      String valueToTest;
      if(filterCol >= 0)
        valueToTest = f.cells[filterCol].toString();

      if(filterFunction == null || filterCol >= 0 && filterFunction != null && filterFunction(valueToTest, filterValue))
        datatable.add(SmeupGraphData(x, y));
    });

    return datatable;
  }

  void setOptions(SmeupJsonComponent smeupJsonComponent) {
    
    if(smeupJsonComponent.options != null) {
      if(smeupJsonComponent.options["CHA"] != null) {
        if(smeupJsonComponent.options["CHA"]["default"] != null) {
          if(smeupJsonComponent.options["CHA"]["default"]["refresh"] != null) 
            refreshMilliseconds = smeupJsonComponent.options["CHA"]["default"]["refresh"];
          if(smeupJsonComponent.options["CHA"]["default"]["types"] != null) 
            chartType = smeupJsonComponent.options["CHA"]["default"]["types"][0];
        }
      }
    }
  }

}



class SmeupGraphData {
  double x;
  double y;

  SmeupGraphData(this.x, this.y);
}