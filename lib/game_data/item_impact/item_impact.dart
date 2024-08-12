import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/game_data/enemy/enemy_model.dart';
import 'package:lady_bug/game_data/game_data.dart';
import 'package:lady_bug/game_data/item_impact/circle_item.dart';

class ItemImpactPainter extends CustomPainter {
  GameData gameData = GameData();

  ItemImpactPainter();

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

  void drawingShieldItem(Canvas canvas) {
    if (gameData.shieldTime <= 0) {
      return;
    }
    final Paint abilityPaint1 = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    final Offset center = Offset(
      gameData.currentPosition.dx + playerSize / 2,
      gameData.currentPosition.dy + playerSize / 2,
    );

    ///쉴드 회전
    double rotationAngle = pi * gameData.shieldTime;

    final Path trianglePath = Path();
    for (int i = 0; i < 3; i++) {
      double angle = 2 * pi / 3 * i - pi / 2;
      final double x = center.dx + triangleSize * cos(angle);
      final double y = center.dy + triangleSize * sin(angle);
      if (i == 0) {
        trianglePath.moveTo(x, y);
      } else {
        trianglePath.lineTo(x, y);
      }
    }
    trianglePath.close();

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotationAngle);
    canvas.translate(-center.dx, -center.dy);

    canvas.drawPath(trianglePath, abilityPaint1);

    canvas.restore();

    // 충돌 판정
    List<EnemyModel> enemiesToRemove = [];
    for (int i = 0; i < gameData.enemyList.length; i++) {
      final enemyRect = Rect.fromCircle(
        center: gameData.enemyList[i].currentPosition,
        radius: enemySize, // 충돌 판정 조절하기
      );

      final Rect triangleBounds = Rect.fromPoints(
        Offset(center.dx - triangleSize, center.dy - triangleSize),
        Offset(center.dx + triangleSize, center.dy + triangleSize),
      );

      if (triangleBounds.overlaps(enemyRect)) {
        enemiesToRemove.add(gameData.enemyList[i]);
      }
    }

    for (var item in enemiesToRemove) {
      gameData.enemyList.remove(item); // 적 제거
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawingShieldItem(canvas);

    for (var model in gameData.itemImpactList) {
      if (model is CircleItemModel) {
        ///원 폭탄인 경우
        drawingCircleItem(canvas, model);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
