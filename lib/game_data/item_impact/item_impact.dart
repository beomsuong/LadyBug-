import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/game_data/enemy/enemy_model.dart';
import 'package:lady_bug/game_data/game_data.dart';
import 'package:lady_bug/game_data/item_impact/circle_item.dart';

class ItemImpactPainter extends CustomPainter {
  final dynamic itemImpactModel;
  GameData gameData = GameData();

  ItemImpactPainter(this.itemImpactModel);

  ///원 폭탄 그리기
  void drawingCircleItem(Canvas canvas, CircleItemModel circleItemModel) {
    circleItemModel.circleSize += 1;

    if (circleItemModel.circleSize > 1000) {
      ///최대 사이즈이면 삭제
      gameData.itemImpactList.removeWhere((data) => data == circleItemModel);
      return;
    }
    final Paint abilityPaint1 = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    //큰원 계산
    final Rect rect1 = Rect.fromCircle(
      center: Offset(circleItemModel.currentPosition.dx,
          circleItemModel.currentPosition.dy),
      radius: circleItemModel.circleSize,
    );
    // 작은원 계산
    final Rect rect2 = Rect.fromCircle(
      center: Offset(circleItemModel.currentPosition.dx,
          circleItemModel.currentPosition.dy),
      radius: circleItemModel.circleSize - 10,
    );

    List<EnemyModel> enemiesToRemove = []; //삭제 할 적 리스트
    for (int i = 0; i < gameData.enemyList.length; i++) {
      final enemyRect = Rect.fromCircle(
          center: gameData.enemyList[i].currentPosition,
          radius: enemySize); //충돌 판정 조절하기

      if (rect1.overlaps(enemyRect) && !rect2.overlaps(enemyRect)) {
        //큰원에 겹치고 작은 원에는 안겹치게
        enemiesToRemove.add(gameData.enemyList[i]);
      }
    }
    for (var item in enemiesToRemove) {
      gameData.enemyList.remove(item); // 적제거
    }

    //원 그리기
    canvas.drawCircle(rect1.center, rect1.width / 2, abilityPaint1);
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (itemImpactModel is CircleItemModel) {
      ///원 폭탄인 경우
      drawingCircleItem(canvas, itemImpactModel);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
