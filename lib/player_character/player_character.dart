import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';

class PlayerCharacter extends CustomPainter {
  final Offset position;
  final List<ItemModel> itemList;
  PlayerCharacter(this.position, this.itemList);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    final Rect rect =
        Rect.fromLTWH(position.dx, position.dy, playerSize, playerSize);

    List<ItemModel> itemsToRemove = []; //삭제 할 아이템 리스트

    for (int i = 0; i < itemList.length; i++) {
      final itemRect = Rect.fromLTWH(
          itemList[i].currentPosition.dx + 15,
          itemList[i].currentPosition.dy + 15,
          monsterSize - 30,
          monsterSize - 30); //충돌 판정 조절하기
      if (rect.overlaps(itemRect)) {
        //충돌 감지
        itemsToRemove.add(itemList[i]);
      }
    }
    for (var item in itemsToRemove) {
      itemList.remove(item); //아이템 제거
    }
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
