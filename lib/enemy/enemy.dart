import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/enemy/enemy_model.dart';

class EnemyPainter extends CustomPainter {
  final EnemyModel enemyModel;

  EnemyPainter(this.enemyModel);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = enemyColor()
      ..style = PaintingStyle.fill;
    canvas.drawCircle(enemyModel.currentPosition, enemySize, paint);
  }

  Color enemyColor() {
    if (enemyModel.type == EnemyType.normal) {
      return Colors.green;
    }
    return Colors.black;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
