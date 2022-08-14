import 'package:flutter/material.dart';
import 'package:quantt/views/matches.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QunTTit',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home:  matches(title: 'QuanTT | Dashboard'),
    );
  }
}




