import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
//hive ei folder er bitor data save korar jonno
import 'package:path_provider/path_provider.dart';

class Pref{
  // hive er data box er bitor rakhar jonno
  // late use hoy pore data initialize er jonno, ekhon value nei
  static late Box _box;

  static Future<void> initialize() async {
  //   For initializing hive to use app directory
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    // mydata name box open korte
    _box = Hive.box(name: 'myData');
  }
  // 1st time Onboarding screen dekhanor jonno
  static bool get showOnboarding =>
      _box.get('showOnboarding', defaultValue: true);

  //1st time er por jeno r Onboarding tar jonno data save
  static set showOnboarding(bool v) => _box.put('showOnboarding', v);

  //For storing theme data
  static bool get isDarkMode => _box.get('isDarkMode') ?? false;
  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static ThemeMode get defaultTheme{
    final data = _box.get('isDarkMode');
    // hive theke ki value ashce ta consol dekhe bhujar jono
    log('data: $data');
    // Theme save kora hoy nai, tai phn er theme flw korar jonno
    if(data == null) return ThemeMode.system;
    // data true mane dark mode on
    if(data == true) return ThemeMode.dark;
    // else return bright
    return ThemeMode.light;
  }
}