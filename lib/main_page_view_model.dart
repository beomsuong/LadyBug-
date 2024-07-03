import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';

class MainPageViewModel extends ChangeNotifier {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset currentPosition = const Offset(100, 100);
  Offset _targetPosition = const Offset(100, 100);

  List<ItemModel> itemList = [];

  MainPageViewModel({required TickerProvider vsync}) {
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        currentPosition = _animation.value;
        notifyListeners();
      });

    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      debugPrint('아이템 갯수 : ${itemList.length}');
      List<ItemModel> itemsToRemove = [];
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
        itemList.remove(item);
      }
      notifyListeners();
    });
  }

  void updatePosition(StickDragDetails details) {
    double moveX = details.x, moveY = details.y;
    if ((currentPosition.dx <= playerSize && details.x <= 0) ||
        (currentPosition.dx >= screenWidth - playerSize && details.x >= 0)) {
      moveX = 0;
    }
    if ((currentPosition.dy <= playerSize && details.y <= 0) ||
        (currentPosition.dy >= screenHeight - playerSize && details.y >= 0)) {
      moveY = 0;
    }
    details.x + 10;
    _targetPosition += Offset(moveX * playerSpeed, moveY * playerSpeed);
    _animateToPosition();
  }

  void _animateToPosition() {
    _animation = Tween<Offset>(
      begin: currentPosition,
      end: _targetPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.reset();
    _controller.forward();
  }

  void addItem() {
    var randomX = Random().nextDouble() * screenWidth;
    var randomY = Random().nextDouble() * screenHeight;
    var randomSpeedX = (Random().nextDouble() * speedLevel * 2) - speedLevel;
    var randomSpeedY = (Random().nextDouble() * speedLevel * 2) - speedLevel;
    itemList.add(ItemModel(
        currentPosition: Offset(randomX, randomY),
        velocity: Offset(randomSpeedX, randomSpeedY),
        type: 1));
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
