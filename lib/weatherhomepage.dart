import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_json/weather.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() {
    return _WeatherHomePageState();
  }
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  List<charts.Series<Weather, String>> _seriesPieData;
  List<Weather> mydata;
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<Weather, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Weather task, _) => task.day,
        measureFn: (Weather task, _) => task.min,
        colorFn: (Weather task, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'NewYork',
        data: mydata,
        labelAccessorFn: (Weather row, _) => "${row.min}'..'${row.max}",
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //_seriesPieData = List<charts.Series<Weather, String>>();
    mydata = mydata;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NewYork')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('weather').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Weather> weather = snapshot.data.documents
              .map((documentSnapshot) => Weather.fromMap(documentSnapshot.data))
              .toList();
          return _buildList(context, weather);
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<Weather> snapshot) {
    return _buildListItem(context, snapshot);
  }

  Widget _buildListItem(BuildContext context, List<Weather> weatherdata) {
    mydata = weatherdata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Time spent on daily tasks',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                            charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                            new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 11),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}