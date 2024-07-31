import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';
import 'dart:math';

class ItemPainter extends CustomPainter {
  final ItemModel itemModel;

  ItemPainter(this.itemModel);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = itemColor()
      ..style = PaintingStyle.fill;

    final double cx = itemModel.currentPosition.dx + itemSize / 2;
    final double cy = itemModel.currentPosition.dy + itemSize / 2;
    const double outerRadius = itemSize / 2;
    const double innerRadius = outerRadius / 2.5;
    const int points = 5;
    const double step = pi / points;

    final Path path = Path();

    for (int i = 0; i < points * 2; i++) {
      double radius = (i % 2 == 0) ? outerRadius : innerRadius;
      double x = cx + radius * cos(i * step - pi / 2);
      double y = cy + radius * sin(i * step - pi / 2);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  Color itemColor() {
    if (itemModel.type == ItemType.speedUp) {
      return Colors.red;
    } else if (itemModel.type == ItemType.speedDown) {
      return Colors.blue;
    } else if (itemModel.type == ItemType.circle) {
      return Colors.purple;
    } else if (itemModel.type == ItemType.shield) {
      return Colors.brown;
    }
    return Colors.black;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
