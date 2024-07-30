import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/game_data/enemy/enemy_model.dart';
import 'package:lady_bug/item/item_model.dart';

class GameData {
  static final GameData _instance = GameData._internal();
  double currentTime = 0.0;
  Offset currentPosition = Offset(screenWidth / 2, screenHeight / 2);
  Offset targetPosition = Offset(screenWidth / 2, screenHeight / 2);

  List<ItemModel> itemList = []; //아이템리스트
  List<EnemyModel> enemyList = []; //적리스트
  List<dynamic> itemImpactList = []; //아이템 효과 그리기

  int playerLife = 10;
  double booster = 0; //아이템 획득 시 가속 OR 감속

  ///게임 리셋
  void gameReset() {
    currentTime = 0.0;
    currentPosition = Offset(screenWidth / 2, screenHeight / 2);
    targetPosition = Offset(screenWidth / 2, screenHeight / 2);
    itemList = [];
    enemyList = [];
    itemImpactList = [];
    playerLife = 10;
    booster = 0;
  }

  GameData._internal();

  factory GameData() {
    return _instance;
  }
}
