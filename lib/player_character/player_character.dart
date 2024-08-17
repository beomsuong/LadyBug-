import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lady_bug/game_data/item_impact/circle_item.dart';
import 'package:lady_bug/game_data/enemy/enemy_model.dart';
import 'package:lady_bug/game_data/game_data.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';
import 'package:lady_bug/view_model/sound_view_model.dart';

class PlayerCharacter extends CustomPainter {
  PlayerCharacter();
  GameData gameData = GameData();

  ///플레이어 그리기
  void drawingPlayer(Canvas canvas) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // 플레이어 사각형 그리기
    final Rect rect = Rect.fromLTWH(
      gameData.currentPosition.dx,
      gameData.currentPosition.dy,
      playerSize,
      playerSize,
    );
    canvas.drawRect(rect, paint);

    // 얼굴 요소 그리기 (사각형 안에 표정)
    final double faceCenterX = gameData.currentPosition.dx + playerSize / 2;
    final double faceCenterY = gameData.currentPosition.dy + playerSize / 2;
    const double eyeRadius = playerSize * 0.1;
    const double eyeOffsetX = playerSize * 0.2;
    const double eyeOffsetY = playerSize * 0.2;
    const double mouthWidth = playerSize * 0.4;
    const double mouthHeight = playerSize * 0.2;

    final Paint facePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Paint mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // 왼쪽 눈 그리기
    canvas.drawCircle(
      Offset(faceCenterX - eyeOffsetX, faceCenterY - eyeOffsetY),
      eyeRadius,
      eyePaint,
    );

    // 오른쪽 눈 그리기
    canvas.drawCircle(
      Offset(faceCenterX + eyeOffsetX, faceCenterY - eyeOffsetY),
      eyeRadius,
      eyePaint,
    );

    // 입 그리기 (웃는 입)
    final Rect mouthRect = Rect.fromCenter(
      center: Offset(faceCenterX, faceCenterY + eyeOffsetY),
      width: mouthWidth,
      height: mouthHeight,
    );
    canvas.drawArc(mouthRect, 0, pi, true, mouthPaint);
    checkPlayer();
  }

  ///플레이어 아이템, 적 충돌처리
  void checkPlayer() {
    // 플레이어 사각형 크기
    final Rect rect = Rect.fromLTWH(
      gameData.currentPosition.dx,
      gameData.currentPosition.dy,
      playerSize,
      playerSize,
    );
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
      } else if (rect.overlaps(itemRect) &&
          gameData.itemList[i].type == ItemType.circle) {
        //충돌 감지
        gameData.itemImpactList.add(CircleItemModel(
            currentPosition: Offset(
                gameData.currentPosition.dx + playerSize / 2,
                gameData.currentPosition.dy + playerSize / 2)));
        itemsToRemove.add(gameData.itemList[i]);
      } else if (rect.overlaps(itemRect) &&
          gameData.itemList[i].type == ItemType.shield) {
        //충돌 감지

        gameData.shieldTime = 10;
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
        if (gameData.playerLife <= 0) {
          SoundViewModel().playBackgroundMusic();
          SoundViewModel().playEffectSound('game_over');
          gameData.gameEnd = true;
        }
        enemiesToRemove.add(gameData.enemyList[i]); //아이템 제거
      }
    }
    for (var item in enemiesToRemove) {
      gameData.enemyList.remove(item); //아이템 제거
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawingPlayer(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
