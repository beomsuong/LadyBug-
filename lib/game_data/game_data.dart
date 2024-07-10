import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';

class GameData {
  static final GameData _instance = GameData._internal();
  double currentTime = 0.0;
  Offset currentPosition = Offset(screenWidth / 2, screenHeight / 2);
  Offset targetPosition = Offset(screenWidth / 2, screenHeight / 2);

  List<ItemModel> itemList = [];
  int playerLife = 10;

  ///게임 리셋
  void gameReset() {
    currentTime = 0.0;
    currentPosition = Offset(screenWidth / 2, screenHeight / 2);
    targetPosition = Offset(screenWidth / 2, screenHeight / 2);
    itemList = [];
    playerLife = 10;
  }

  GameData._internal();

  factory GameData() {
    return _instance;
  }
}
