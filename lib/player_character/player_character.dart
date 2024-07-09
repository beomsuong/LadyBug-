import 'package:flutter/material.dart';
import 'package:lady_bug/data_class.dart';
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
          monsterSize - 30,
          monsterSize - 30); //충돌 판정 조절하기
      if (rect.overlaps(itemRect)) {
        //충돌 감지
        itemsToRemove.add(gameData.itemList[i]);
      }
    }
    for (var item in itemsToRemove) {
      gameData.itemList.remove(item); //아이템 제거
    }
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
