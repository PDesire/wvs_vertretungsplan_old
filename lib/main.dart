import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:wvs_plan/pages/MainPage/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WVS Vertretungsplan',
      theme: ThemeData.dark().copyWith(
        canvasColor: Color.fromRGBO(25, 39, 62, 1),
        backgroundColor: Color.fromRGBO(31, 50, 69, 1),
        bottomAppBarColor: Color.fromRGBO(39, 59, 89, 1),
        buttonColor: Colors.red[600],
        indicatorColor: Colors.red,
      ),
      home: DefaultBottomBarController(
          child: MainPage()
      ),
    );
  }
}
