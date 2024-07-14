import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/game_data/game_data.dart';
import 'package:lady_bug/game_data/setting_data.dart';
import 'package:lady_bug/item/item_model.dart';
import 'package:lady_bug/view_model/sound_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_page_view_model.g.dart';

@riverpod
class MainPageViewModel extends _$MainPageViewModel with ChangeNotifier {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  GameData gameData = GameData();
  SettingData settingData = SettingData();
  late SoundViewModel soundViewModel;

  @override
  Future<void> build(TickerProvider vsync) async {
    soundViewModel = SoundViewModel();
    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        gameData.currentPosition = _animation.value;
        notifyListeners();
      });

    Timer.periodic(const Duration(milliseconds: 10), (Timer timer) {
      if (settingData.gameStop) {
        return;
      }
      gameData.currentTime += 0.01; // 게임 시간초

      debugPrint('아이템 갯수 : ${gameData.itemList.length}');
      List<ItemModel> itemsToRemove = [];
      for (var item in gameData.itemList) {
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
        gameData.itemList.remove(item);
      }

      notifyListeners();
    });
  }

  ///오디오 파일 불러오고 재생

  void updatePosition(StickDragDetails details) {
    double moveX = details.x, moveY = details.y;
    if ((gameData.currentPosition.dx <= playerSize && details.x <= 0) ||
        (gameData.currentPosition.dx >= screenWidth - playerSize &&
            details.x >= 0)) {
      moveX = 0;
    }
    if ((gameData.currentPosition.dy <= playerSize && details.y <= 0) ||
        (gameData.currentPosition.dy >= screenHeight - playerSize &&
            details.y >= 0)) {
      moveY = 0;
    }
    gameData.targetPosition += Offset(moveX * playerSpeed, moveY * playerSpeed);
    animateToPosition();
  }

  void animateToPosition() {
    _animation = Tween<Offset>(
      begin: gameData.currentPosition,
      end: gameData.targetPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.reset();
    _controller.forward();
  }

  void addItem() {
    var randomX = Random().nextDouble() * screenWidth;
    var randomY = Random().nextDouble() * screenHeight;
    var randomSpeedX = (Random().nextDouble() * speedLevel * 2) - speedLevel;
    var randomSpeedY = (Random().nextDouble() * speedLevel * 2) - speedLevel;
    gameData.itemList.add(ItemModel(
        currentPosition: Offset(randomX, randomY),
        velocity: Offset(randomSpeedX, randomSpeedY),
        type: 1));
    notifyListeners();
  }

  void resetGame() {
    gameData.gameReset();
    soundViewModel.playBackgroundMusic();
    soundViewModel.playEffectSound('game_start');
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}
