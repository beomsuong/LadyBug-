class CircleItem {
  static final CircleItem _instance = CircleItem._internal();
  bool on = false;
  num circleSize = 0;

  void circleReset() {
    on = false;
    circleSize = 0;
  }

  CircleItem._internal();

  factory CircleItem() {
    return _instance;
  }
}
