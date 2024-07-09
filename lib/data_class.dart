import 'package:flutter/material.dart';
import 'package:lady_bug/item/item_model.dart';

class GameData {
  static final GameData _instance = GameData._internal();

  Offset currentPosition = const Offset(100, 100);
  Offset targetPosition = const Offset(100, 100);

  List<ItemModel> itemList = [];
  int playerLife = 10;

  GameData._internal();

  factory GameData() {
    return _instance;
  }
}
