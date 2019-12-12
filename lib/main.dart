import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jungkook_app/screens/HomeScreen.dart';
import 'package:jungkook_app/utils/Common.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static var platform = MethodChannel(Common.CHANNEL);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
