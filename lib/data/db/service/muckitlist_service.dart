import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/muckit_list.dart';

class MuckitListService {
  addMuckitList(MuckitList data) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      INSERT INTO ${MuckitList.tableName}(
            ${MuckitListField.id},
            ${MuckitListField.name},
            ${MuckitListField.date},
            ) VALUES(?, ?)
    ''';
    await db.transaction((txn) async {
      return await txn.rawInsert(sql, [data.name, data.date]);
    });
  }

  // 전체 조회
  Future<List<MuckitList>> getAllMuckitList() async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${MuckitList.tableName}
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return MuckitList.toList(result);
  }

  updateDietList(args) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${MuckitList.tableName} 
      SET
        ${MuckitListField.name} = ? , ${MuckitListField.date} = ?
      WHERE
        ${MuckitListField.id} = ?
    ''';
    await db.rawUpdate(sql, args);
  }

  deleteDietList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${MuckitList.tableName} WHERE ${MuckitListField.id} = $id
    ''';
    await db.rawDelete(sql);
  }
}
