import 'package:flutter/material.dart';
import 'package:transform_testing/transform.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Transform Implementation",
      theme: ThemeData(
        fontFamily: 'proxima'
      ),
      home: TransformMainView(),
    );
  }
}