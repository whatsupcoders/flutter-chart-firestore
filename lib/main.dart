
import 'package:flutter/material.dart';
import 'weatherhomepage.dart';
import 'taskhomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Chart',
      //home: WeatherHomePage(),
      home: TaskHomePage(),
    );
  }
}


