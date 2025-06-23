
import 'package:flutter/material.dart';
import 'Home.dart';

class MyApp extends StatefulWidget {


  @override
  @override
  State<MyApp> createState() => _MyApp();

}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsive Design',
      home: Home(),
    );
  }
}

