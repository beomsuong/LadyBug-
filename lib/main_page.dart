import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item.dart';
import 'package:lady_bug/item/item_model.dart';
import 'package:lady_bug/main_page_view_model.dart';
import 'package:lady_bug/player_character/player_character.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late MainPageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MainPageViewModel(vsync: this);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height; // 화면 크기 변경하면 바로 변경
    screenWidth = MediaQuery.sizeOf(context).width; // 화면 크기 변경하면 바로 변경
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _viewModel,
            builder: (context, child) {
              return CustomPaint(
                painter: PlayerCharacter(
                    _viewModel.currentPosition, _viewModel.itemList),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _viewModel,
            builder: (context, child) {
              return Stack(
                children: _viewModel.itemList.map((item) {
                  return CustomPaint(
                    painter: ItemPainter(item),
                    child: const SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Joystick(
                mode: JoystickMode.all,
                listener: (details) {
                  _viewModel.updatePosition(details);
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                _viewModel.addItem();
              },
              child: Container(
                color: Colors.amber,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
