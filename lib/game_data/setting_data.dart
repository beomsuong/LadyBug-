import 'package:flutter/material.dart';
import 'package:lady_bug/item/item_model.dart';

class SettingData {
  static final SettingData _instance = SettingData._internal();

  bool gameStop = false;

  ///게임 리셋
  void settingReset() {}

  SettingData._internal();

  factory SettingData() {
    return _instance;
  }
}
