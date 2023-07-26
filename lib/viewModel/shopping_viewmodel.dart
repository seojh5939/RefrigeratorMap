import 'package:flutter/material.dart';
import 'package:refrigerator_map/data/db/service/checklist_service.dart';
import 'package:refrigerator_map/data/db/service/shopping_service.dart';
import 'package:refrigerator_map/data/model/checklist.dart';
import 'package:refrigerator_map/data/model/shopping.dart';

/// 장보기 ViewModel
class ShoppingViewModel extends ChangeNotifier {
  final _shoppingService = ShoppingService();
  final _checkListService = CheckListService();

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  List<bool> isSelectedToggleBtn = [true, false]; // 장보기 목록, 장보기 완료 토글버튼

  refreshPage() {
    notifyListeners();
  }

  changeSelectedToggle(int index) {
    for (int i = 0; i < isSelectedToggleBtn.length; i++) {
      isSelectedToggleBtn[i] = i == index;
    }
    notifyListeners();
  }

  bool isSameDay(DateTime day) {
    return selectedDay == day;
  }

  changeday(DateTime focused, DateTime selected) {
    focusedDay = focused;
    selectedDay = selected;
    notifyListeners();
  }

  Future<List<Shopping>> getAllShoppingList() async {
    return await _shoppingService.getAllShoppingList();
  }

  Future<List<Shopping>> getShoppingList(String date) async {
    return await _shoppingService.getShoppingListByRegDate(date);
  }

  Future<Shopping?> getShoppingListByTitle(String title) async {
    return await _shoppingService.getShoppingListByTitle(title);
  }

  addShopingList(Shopping data) {
    _shoppingService.addShoppingList(data);
    notifyListeners();
  }

  addCheckList(CheckList data) {
    _checkListService.addCheckList(data);
    notifyListeners();
  }

  updateShoppingList(Shopping data) {
    _shoppingService
        .updateShoppingList([data.title, data.regdate, data.isdone, data.id]);
    notifyListeners();
  }

  updateIsDone(String id, String isdone) {
    _shoppingService.updateIsDone(id, isdone);
    notifyListeners();
  }

  removeShoppingList(int id) {
    _shoppingService.deleteShoppingList(id);
    notifyListeners();
  }

  Future<List<CheckList>> getAllCheckList(String title) async {
    return await _checkListService.getShoppingCheckListByTitle(title);
  }

  refreshCheckBox({required bool? changeValue, required int id}) async {
    await _checkListService.updateCheckState(changeValue == true ? 1 : 0, id);
    notifyListeners();
  }

  Future<int> getTotalAmount(String title) async {
    List<CheckList> list =
        await _checkListService.getShoppingCheckListByTitle(title);
    int total = 0;
    if (list.isEmpty) return total;
    for (int i = 0; i < list.length; i++) {
      total += list[i].amount;
    }
    return total;
  }
}
