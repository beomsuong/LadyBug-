import 'dart:ui';

class EnemyModel {
  Offset currentPosition; //현재 위치
  Offset velocity; // 객체가 이동할 방향 + 속도
  EnemyType type; // 객체의 타입 ex)아이템 종류, 적 종류

  EnemyModel(
      {required this.currentPosition,
      required this.velocity,
      required this.type,
      r});
}

enum EnemyType { normal }
