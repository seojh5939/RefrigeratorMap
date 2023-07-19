import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/diet.dart';

class DietService {
  addDietList(Diet data) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      INSERT INTO ${Diet.tableName}(
            ${DietField.id},
            ${DietField.name},
            ${DietField.date},
            ${DietField.mealtime},
            ${DietField.memo}
            ) VALUES(?, ?, ?, ?)
    ''';
    await db.rawInsert(sql, [data.name, data.date, data.mealtime, data.memo]);
  }

  // 전체 조회
  Future<List<Diet>> getAllDietList() async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Diet.tableName}
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return Diet.toList(result);
  }

  updateDietList(args) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${Diet.tableName} 
      SET
        ${DietField.name} = ? , ${DietField.date} = ?, ${DietField.mealtime} = ?, ${DietField.memo} = ?
      WHERE
        ${DietField.id} = ?
    ''';
    await db.rawUpdate(sql, args);
  }

  deleteDietList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${Diet.tableName} WHERE ${DietField.id} = $id
    ''';
    await db.rawDelete(sql);
  }
}
