
import 'package:flutter/material.dart';
import 'taskhomepage.dart';
import 'saleshomepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Chart',
      theme: ThemeData(
        primaryColor: Color(0xff543B7A),
        // primaryColor: Color(0xfff18226),
      ),
      home: TaskHomePage(),
       // home:SalesHomePage(),
    );
  }
}


