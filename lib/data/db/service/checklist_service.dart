import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/checklist.dart';

class CheckListService {
  addCheckList(CheckList data) async {
    var db = await DBHelper.instance.database;
    db.transaction((txn) async {
      String sql = 'INSERT INTO checklist(id, title, content, amount, ischeck)';
    });
  }

  // 날짜별 장보기 목록조회
  List<CheckList> getShoppingCheckList(String title) {
    return [];
  }

  updateCheckList(int id) {}

  deleteCheckList(int id) {}
}
