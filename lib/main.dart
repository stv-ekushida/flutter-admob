import 'package:flutter/material.dart';
import 'package:flutter_admob/ad_service.dart';
import 'package:flutter_admob/home_page.dart';

void main() {
  AdService.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AD DEMO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
