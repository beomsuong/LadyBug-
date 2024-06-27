import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:lady_bug/define.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
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

  ///조이스틱 이동 함수
  void _updatePosition(StickDragDetails details) {
    double moveX = details.x, moveY = details.y;
    if ((_currentPosition.dx <= playerSize && details.x <= 0) ||
        (_currentPosition.dx >= MediaQuery.sizeOf(context).width - playerSize &&
            details.x >= 0)) {
      //y축 이동 제한
      moveX = 0;
    }
    if ((_currentPosition.dy <= playerSize && details.y <= 0) ||
        (_currentPosition.dy >=
                MediaQuery.sizeOf(context).height - playerSize &&
            details.y >= 0)) {
      //y축 이동 제한
      moveY = 0;
    }
    details.x + 10;
    _targetPosition += Offset(moveX * playerSpeed, moveY * playerSpeed);
    _animateToPosition();
  }

  //캐릭터 이동
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
      body: Stack(
        children: [
          CustomPaint(
            painter: PlayerCharacter(_currentPosition, itemList),
            child: const SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          for (var i in itemList)
            CustomPaint(
              painter: ItemPainter(i),
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

class ItemPainter extends CustomPainter {
  final Offset position;

  ItemPainter(this.position);

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

class PlayerCharacter extends CustomPainter {
  final Offset position;
  final List<Offset> itemList;
  PlayerCharacter(this.position, this.itemList);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final double startX = position.dx - playerSize / 2;
    final double startY = position.dy - playerSize / 2;

    final Rect rect = Rect.fromLTWH(startX, startY, playerSize, playerSize);

    List<Offset> itemsToRemove = [];

    for (int i = 0; i < itemList.length; i++) {
      final itemRect = Rect.fromLTWH(itemList[i].dx + 10, itemList[i].dy + 10,
          monsterSize - 30, monsterSize - 30);
      if (rect.overlaps(itemRect)) {
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
