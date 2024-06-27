import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/define.dart';

class AnimationPage extends StatefulWidget {
  final String title;
  const AnimationPage({super.key, required this.title});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  Offset _currentPosition = const Offset(100, 100);
  Offset _targetPosition = const Offset(100, 100);
  List<Offset> itemList = [const Offset(100, 100), const Offset(200, 200)];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _controller.addListener(() {
      setState(() {
        _currentPosition = _animation.value;
      });
    });
  }

  void _updatePosition(StickDragDetails details) {
    double moveX = details.x, moveY = details.y;
    if ((_currentPosition.dx <= 50 && details.x <= 0) ||
        (_currentPosition.dx >= MediaQuery.sizeOf(context).width - 50 &&
            details.x >= 0)) {
      //y축 이동 제한
      moveX = 0;
    }

    if ((_currentPosition.dy <= 50 && details.y <= 0) ||
        (_currentPosition.dy >= MediaQuery.sizeOf(context).height - 50 &&
            details.y >= 0)) {
      //y축 이동 제한
      moveY = 0;
    }

    details.x + 10;
    _targetPosition += Offset(moveX * playerSpeed, moveY * playerSpeed);
    _animateToPosition();
  }

  void _animateToPosition() {
    _animation = Tween<Offset>(
      begin: _currentPosition,
      end: _targetPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: RectanglePainter(_currentPosition, itemList),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          for (var i in itemList)
            CustomPaint(
              painter: ItemPainter1(i),
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Joystick(
                mode: JoystickMode.all,
                listener: _updatePosition,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemPainter1 extends CustomPainter {
  final Offset position;

  ItemPainter1(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final Rect rect =
        Rect.fromLTWH(position.dx, position.dy, monsterSize, monsterSize);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ItemPainter extends CustomPainter {
  final Offset position;

  ItemPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    final Rect rect =
        Rect.fromLTWH(position.dx, position.dy, monsterSize, monsterSize);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RectanglePainter extends CustomPainter {
  final Offset position;
  final List<Offset> itemList;
  RectanglePainter(this.position, this.itemList);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    const double rectWidth = 50;
    const double rectHeight = 50;
    final double startX = position.dx - rectWidth / 2;
    final double startY = position.dy - rectHeight / 2;

    final Rect rect = Rect.fromLTWH(startX, startY, rectWidth, rectHeight);
    print('$startX, $startY, $rectWidth, $rectHeight');

    List<Offset> itemsToRemove = [];

    for (int i = 0; i < itemList.length; i++) {
      final itemRect = Rect.fromLTWH(itemList[i].dx + 10, itemList[i].dy + 10,
          rectWidth - 30, rectHeight - 30);
      if (rect.overlaps(itemRect)) {
        print(
            '!!${itemList[i].dx}, ${itemList[i].dy}, $rectWidth, $rectHeight');
        itemsToRemove.add(itemList[i]);
      }
    }

    for (var item in itemsToRemove) {
      itemList.remove(item);
    }

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
