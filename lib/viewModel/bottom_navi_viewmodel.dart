import 'package:flutter/material.dart';

class BottomNaviViewModel extends ChangeNotifier {
  int bottomIdx = 0;

  /// BottomNavigationItem 인덱스 변경(페이지 이동)
  changeItem(int idx) {
    bottomIdx = idx;
    notifyListeners();
  }
}
