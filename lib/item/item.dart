import 'package:flutter/material.dart';
import 'package:lady_bug/define.dart';
import 'package:lady_bug/item/item_model.dart';

class ItemPainter extends CustomPainter {
  final ItemModel itemModel;

  ItemPainter(this.itemModel);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = itemColor()
      ..style = PaintingStyle.fill;

    final Rect rect = Rect.fromLTWH(itemModel.currentPosition.dx,
        itemModel.currentPosition.dy, itemSize, itemSize);
    canvas.drawRect(rect, paint);
  }

  Color itemColor() {
    if (itemModel.type == ItemType.speedUp) {
      return Colors.red;
    }
    return Colors.black;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
