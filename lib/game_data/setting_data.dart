//게임 세팅값 저장
class SettingData {
  static final SettingData _instance = SettingData._internal();

  bool gameStop = false;
  double gameVolume = 1;

  ///게임 리셋
  void settingReset() {}

  SettingData._internal();

  factory SettingData() {
    return _instance;
  }
}
