// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(
          bodyText2:
              TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
      ),
      home: HomePage(),
    );
  }
}
