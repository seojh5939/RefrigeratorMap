import 'package:flutter/material.dart';

class DietViewModel extends ChangeNotifier {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  var isSelectedList = List.generate(7, (index) => false);

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
