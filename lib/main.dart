import 'package:flutter/material.dart';
import 'package:lady_bug/main_page.dart';
import 'package:lady_bug/define.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MainPage(),
    );
  }
}
