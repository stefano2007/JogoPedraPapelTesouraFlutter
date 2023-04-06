import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  static AppController instance = new AppController();
  bool isModoNoturno = false;

  changeModoNoturno(){
    this.isModoNoturno = !this.isModoNoturno;
    debugPrint('changeModoNoturno ${this.isModoNoturno}');
    notifyListeners();
  }
}