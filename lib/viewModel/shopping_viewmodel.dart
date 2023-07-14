import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:refrigerator_map/data/model/shopping.dart';
import 'package:refrigerator_map/main.dart';
import 'package:refrigerator_map/util/preference_keys.dart';

/// 장보기 ViewModel
class ShoppingViewModel extends ChangeNotifier {
  ShoppingViewModel() {
    load();
  }

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
    save();
    notifyListeners();
  }

  removeShoppingList(int index) {
    shoppingList.removeAt(index);
    save();
    notifyListeners();
  }

  updateShoppingList(int index, Shopping data) {
    shoppingList[index] = data;
    save();
    notifyListeners();
  }

  save() {
    List list = shoppingList.map((shopping) => shopping.toJson()).toList();
    String jsonString = jsonEncode(list);
    prefs.setString(PreferenceKeys.shoppingList, jsonString);
  }

  load() {
    String? jsonString = prefs.getString(PreferenceKeys.shoppingList);
    if (jsonString == null) return;
    List list = jsonDecode(jsonString);
    shoppingList = list.map((json) => Shopping.fromJson(json)).toList();
  }
}
