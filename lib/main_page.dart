import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item.dart';
import 'package:lady_bug/item/item_model.dart';
import 'package:lady_bug/player_character/player_character.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _currentPosition = const Offset(100, 100);
  Offset _targetPosition = const Offset(100, 100);

  List<ItemModel> itemList = [
    ItemModel(
        currentPosition: const Offset(200, 200),
        velocity: const Offset(0, 1),
        type: 1)
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controller.addListener(() {
      setState(() {
        _currentPosition = _animation.value;
      });
    });

    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      debugPrint('아이템 갯수 : ${itemList.length}');
      setState(() {
        List<ItemModel> itemsToRemove = []; // 삭제할 아이템 리스트

        for (var item in itemList) {
          item.currentPosition = Offset(
            item.currentPosition.dx + item.velocity.dx,
            item.currentPosition.dy + item.velocity.dy,
          );
          if (item.currentPosition.dx < 0 ||
              item.currentPosition.dx > screenWidth ||
              item.currentPosition.dy < 0 ||
              item.currentPosition.dy > screenHeight) {
            itemsToRemove.add(item);
          }
        }
        for (var item in itemsToRemove) {
          itemList.remove(item); // 아이템 제거
        }
      });
    });
  }

  ///조이스틱 이동 함수
  void _updatePosition(StickDragDetails details) {
    double moveX = details.x, moveY = details.y;
    if ((_currentPosition.dx <= playerSize && details.x <= 0) ||
        (_currentPosition.dx >= screenWidth - playerSize && details.x >= 0)) {
      //y축 이동 제한
      moveX = 0;
    }
    if ((_currentPosition.dy <= playerSize && details.y <= 0) ||
        (_currentPosition.dy >= screenHeight - playerSize && details.y >= 0)) {
      //y축 이동 제한
      moveY = 0;
    }
    details.x + 10;
    _targetPosition += Offset(moveX * playerSpeed, moveY * playerSpeed);
    _animateToPosition();
  }

  //캐릭터 이동
  void _animateToPosition() {
    _animation = Tween<Offset>(
      begin: _currentPosition,
      end: _targetPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.sizeOf(context).height; //화면 크기 변경하면 바로 변경
    screenWidth = MediaQuery.sizeOf(context).width; //화면 크기 변경하면 바로 변경
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: PlayerCharacter(_currentPosition, itemList),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          for (var i in itemList)
            CustomPaint(
              painter: ItemPainter(i),
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Joystick(
                mode: JoystickMode.all,
                listener: _updatePosition,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                print('클릭 ');
                var randomX = Random().nextDouble() * screenWidth;
                var randomY = Random().nextDouble() * screenHeight;
                var randomSpeedX =
                    (Random().nextDouble() * speedLevel * 2) - speedLevel;
                var randomSpeedY =
                    (Random().nextDouble() * speedLevel * 2) - speedLevel;
                itemList.add(ItemModel(
                    currentPosition: Offset(randomX, randomY),
                    velocity: Offset(randomSpeedX, randomSpeedY),
                    type: 1));
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
