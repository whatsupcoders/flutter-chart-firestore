import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_json/Sales.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesHomePage extends StatefulWidget {
  @override
  _SalesHomePageState createState() {
    return _SalesHomePageState();
  }
}

class _SalesHomePageState extends State<SalesHomePage> {
  List<charts.Series<Sales, String>> _seriesBarData;
  List<Sales> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<Sales, String>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => sales.saleYear.toString(),
        measureFn: (Sales sales, _) => sales.saleVal,
        colorFn: (Sales sales, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(sales.colorVal))),
        id: 'Sales',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.saleYear}",
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sales')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('sales').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Sales> sales = snapshot.data.documents
              .map((documentSnapshot) => Sales.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, sales);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Sales by Year',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.BarChart(_seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds:5),
                     behaviors: [
                      new charts.DatumLegend(
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}