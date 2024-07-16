import 'package:flutter/material.dart';
import 'package:lady_bug/game_data/enemy/enemy_model.dart';
import 'package:lady_bug/game_data/game_data.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';

class PlayerCharacter extends CustomPainter {
  PlayerCharacter();
  GameData gameData = GameData();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final Rect rect = Rect.fromLTWH(gameData.currentPosition.dx,
        gameData.currentPosition.dy, playerSize, playerSize);
    List<ItemModel> itemsToRemove = []; //삭제 할 아이템 리스트

    for (int i = 0; i < gameData.itemList.length; i++) {
      final itemRect = Rect.fromLTWH(
          gameData.itemList[i].currentPosition.dx + 15,
          gameData.itemList[i].currentPosition.dy + 15,
          itemSize - 30,
          itemSize - 30); //충돌 판정 조절하기

      if (rect.overlaps(itemRect) &&
          gameData.itemList[i].type == ItemType.speedUp) {
        //충돌 감지
        gameData.booster = 10;
        itemsToRemove.add(gameData.itemList[i]);
      } else if (rect.overlaps(itemRect) &&
          gameData.itemList[i].type == ItemType.speedDown) {
        //충돌 감지
        gameData.booster = -10;
        itemsToRemove.add(gameData.itemList[i]);
      }
    }
    for (var item in itemsToRemove) {
      gameData.itemList.remove(item); //아이템 제거
    }

    List<EnemyModel> enemiesToRemove = []; //삭제 할 적 리스트

    for (int i = 0; i < gameData.enemyList.length; i++) {
      final enemyRect = Rect.fromCircle(
          center: gameData.enemyList[i].currentPosition,
          radius: enemySize); //충돌 판정 조절하기

      if (rect.overlaps(enemyRect)) {
        //충돌 감지
        gameData.playerLife--;
        enemiesToRemove.add(gameData.enemyList[i]); //아이템 제거
      }
    }
    for (var item in enemiesToRemove) {
      gameData.enemyList.remove(item); //아이템 제거
    }

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
