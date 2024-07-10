import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lady_bug/main_page.dart';
import 'package:lady_bug/define.dart';
import 'package:show_fps/show_fps.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height;
    screenWidth = MediaQuery.sizeOf(context).width;
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: ShowFPS(
        alignment: Alignment.topRight,
        visible: false,
        showChart: false,
        borderRadius: BorderRadius.all(Radius.circular(11)),
        child: MainPage(),
      ),
    );
  }
}
