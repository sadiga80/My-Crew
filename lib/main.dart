import 'package:flutter/material.dart';
import 'package:my_crew/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Crew',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.deepOrangeAccent,
          primarySwatch: Colors.blue,
        ),
        home: Home());
  }
}
