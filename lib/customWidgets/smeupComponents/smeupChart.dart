import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:smeup_flutter/main.dart';
import 'package:smeup_flutter/models/smeupChartDatasource.dart';
import 'package:smeup_flutter/models/smeupJsonComponent.dart';
import 'package:smeup_flutter/models/smeupWidgetBuilderResponse.dart';
import 'package:smeup_flutter/services/smeupHttpService.dart';

class SmeupChart extends StatefulWidget {
  final SmeupJsonComponent smeupJsonComponent;

  SmeupChart(this.smeupJsonComponent);

  @override
  _SmeupChartState createState() => _SmeupChartState();
}

class _SmeupChartState extends State<SmeupChart> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: getChartComponent(widget.smeupJsonComponent),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          else {
            return Center(child: snapshot.data.children);
          }
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> getChartComponent(
      SmeupJsonComponent smeupJsonComponent) async {
    var smeupHttpService = MyApp.smeupHttpService;
    var children;

    HttpScriptResponse response;
    if (smeupJsonComponent.fun != null && smeupJsonComponent.fun.isNotEmpty) {
      response = await smeupHttpService.getScript(smeupJsonComponent.fun);

      if (response.isError)
        return SmeupWidgetBuilderResponse(smeupJsonComponent, new Text(response.data));
    }

    var smeupChartDatasource;

    if (response.responseType == HttpResponseType.json) {
      smeupChartDatasource =
          SmeupChartDatasource.fromJson(smeupJsonComponent, response.data);
    } else if (response.responseType == HttpResponseType.influxDB) {
      smeupChartDatasource =
          SmeupChartDatasource.fromInfluxDB(smeupJsonComponent, response.data);
    }

    // TODOO: refresh
    // if(smeupChartDatasource.refreshMilliseconds > 0)
    // {
    //   var duration = Duration(milliseconds: smeupChartDatasource.refreshMilliseconds);
    //   new Timer.periodic(duration, (Timer t) async =>
    //     response = await smeupHttpService.getScript(smeupJsonComponent.fun)
    //   );
    // }

    if (smeupChartDatasource.chartType == "Area")
      children = getAreaChartComponent(
          smeupJsonComponent, response, smeupChartDatasource);
    else if (smeupChartDatasource.chartType == "Line")
      children = getTimeChartComponent(
          smeupJsonComponent, response, smeupChartDatasource);

    return SmeupWidgetBuilderResponse(smeupJsonComponent, children);
  }

  Widget getAreaChartComponent(SmeupJsonComponent smeupJsonComponent,
      HttpScriptResponse response, SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList = List<charts.Series<SmeupGraphData, double>>();

    seriesList.add(
      new charts.Series<SmeupGraphData, double>(
        id: "firstGroup",
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SmeupGraphData sales, _) => sales.x,
        measureFn: (SmeupGraphData sales, _) => sales.y,
        //data: smeupChartDatasource.getDataTable(0, 1, (k, z) { return k == z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 1, -1, null, null),
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    );

    seriesList.add(
      new charts.Series<SmeupGraphData, double>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupGraphData sales, _) => sales.x,
        measureFn: (SmeupGraphData sales, _) => sales.y,
        //data: smeupChartDatasource.getDataTable((k, z) { return k != z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 2, -1, null, null),
      ),
    );

    var chart = new charts.LineChart(seriesList,
        animate: animate,
        customSeriesRenderers: [
          new charts.LineRendererConfig(
              // ID used to link series to this renderer.
              customRendererId: 'customArea',
              includeArea: true,
              stacked: true),
        ]);

    var container = Container(
      child: chart,
      width: 200,
      height: 200,
    );

    return container;
  }

  Widget getTimeChartComponent(SmeupJsonComponent smeupJsonComponent,
      HttpScriptResponse response, SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList = List<charts.Series<SmeupGraphData, DateTime>>();

    seriesList.add(
      new charts.Series<SmeupGraphData, DateTime>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupGraphData sales, _) =>
            new DateTime.fromMillisecondsSinceEpoch(sales.x.truncate()),
        measureFn: (SmeupGraphData sales, _) => sales.y,
        //data: smeupChartDatasource.getDataTable((k, z) { return k != z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 1, -1, null, null),
      ),
    );

    var chart = new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
    );

    var container = Container(
      child: chart,
      width: 200,
      height: 200,
    );

    return container;
  }
}
