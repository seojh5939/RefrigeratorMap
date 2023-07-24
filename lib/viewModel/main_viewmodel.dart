import 'package:flutter/cupertino.dart';
import 'package:refrigerator_map/data/db/service/refrigerator_service.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';

class MainViewModel extends ChangeNotifier {
  var service = RefrigeratorService();
  // List<Refrigerator> itemList = [];
  List<String> list = ["냉장실", "냉동실", "신선칸"];
  var dropdownValue;
  MainViewModel() {
    dropdownValue = list.first;
  }
  applyDropdownValue(value) {
    dropdownValue = value;
    notifyListeners();
  }

  Future<List<Refrigerator>> getAllItems() async {
    return await service.getAllRefrigeratorList();
  }

  Future<List<Refrigerator>> getItemsByPosition(String position) async {
    return await service.getRefrigeratorListByposition(position);
  }

  Future<Refrigerator?> getItemsByName(String name) async {
    return await service.getRefrigeratorListByName(name);
  }

  Future<Refrigerator?> getItemsById(int id) async {
    return await service.getRefrigeratorList(id);
  }

  addItems(Refrigerator data) async {
    await service.addRefrigeratorList(data);
    notifyListeners();
  }

  updateItems(Refrigerator args) async {
    await service.updateRefrigeratorList([
      args.name,
      args.count,
      args.regdate,
      args.expdate,
      args.position,
      args.memo,
      args.id
    ]);
    notifyListeners();
  }

  removeItems(int id) async {
    await service.deleteRefrigeratorList(id);
  }
}
