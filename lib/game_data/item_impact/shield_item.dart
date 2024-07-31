///원형 폭탄
class ShieldItemModel {
  static final ShieldItemModel _instance = ShieldItemModel._internal();
  num itemTime = 0;

  ShieldItemModel._internal();
  factory ShieldItemModel() {
    return _instance;
  }
}
