import 'package:flutter/material.dart';

class DietViewModel extends ChangeNotifier {
  DateTime focusedDay = DateTime.now(); // Calendar 현재 선택된 날짜
  DateTime? selectedDay; // Calendar 선택된 날짜
  var isSelectedList =
      List.generate(7, (index) => false); // 식단표 주간 달력 선택 확인용 List

  bool isSameDay(DateTime day) {
    return selectedDay == day;
  }

  changeday(DateTime focused, DateTime selected) {
    focusedDay = focused;
    selectedDay = selected;
    notifyListeners();
  }

  viewSelectedDay(int index) {
    int trueIdx = isSelectedList.indexWhere((element) => element == true);
    if (trueIdx != -1) {
      isSelectedList[trueIdx] = false;
    }
    isSelectedList[index] = true;
    notifyListeners();
  }
}
