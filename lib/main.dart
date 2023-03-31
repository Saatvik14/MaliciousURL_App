import 'package:flutter/material.dart';
import 'package:t/info.dart';
import 'package:t/screen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
  /*int p = 251001;
  getHttp(p, "25-10-2021");*/
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new Info();
  }
}
