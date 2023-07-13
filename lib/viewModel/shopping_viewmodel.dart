import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/main.dart';

class ShoppingViewModel extends ChangeNotifier {
  List<Shopping> shoppingList = [];
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  bool isSameDay(DateTime day) {
    return selectedDay == day;
  }

  changeday(DateTime focused, DateTime selected) {
    focusedDay = focused;
    selectedDay = selected;
    notifyListeners();
  }

  addShopingList(Shopping data) {
    shoppingList.add(data);
    notifyListeners();
  }

  save() {
    List list = shoppingList.map((shopping) => shopping.toJson()).toList();
    String jsonString = jsonEncode(list);
    prefs.setString('shoppingList', jsonString);
  }

  load() {
    String? jsonString = prefs.getString('shoppingList');
    if (jsonString == null) return;
    List list = jsonDecode(jsonString);
    shoppingList = list.map((json) => Shopping.fromJson(json)).toList();
  }
}
