import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/refrigerator.dart';

class RefrigeratorService {
  addRefrigeratorList(Refrigerator data) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      INSERT ITO ${Refrigerator.tableName}(
            ${RefrigeratorField.name},
            ${RefrigeratorField.count},
            ${RefrigeratorField.regdate},
            ${RefrigeratorField.expdate},
            ${RefrigeratorField.position},
            ${RefrigeratorField.memo}
            ) VALUES(?, ?, ?, ?, ?, ?)
    ''';
    await db.rawInsert(sql, [
      data.name,
      data.count,
      data.regdate,
      data.expdate,
      data.position,
      data.memo
    ]);
  }

  // 전체 조회
  Future<List<Refrigerator>> getAllRefrigeratorList() async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Refrigerator.tableName}
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return Refrigerator.toList(result);
  }

  // 개별 조회
  Future<Refrigerator?> getRefrigeratorList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Refrigerator.tableName} WHERE ${RefrigeratorField.id} = '$id'
    ''';
    var args = [];
    List<Map>? resultQuery = await db.rawQuery(sql, args);

    return Refrigerator.toList(resultQuery).firstOrNull;
  }

  // 개별 조회
  Future<List<Refrigerator>> getRefrigeratorListByposition(
      String position) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Refrigerator.tableName} WHERE ${RefrigeratorField.position} = '$position'
    ''';
    var args = [];
    List<Map>? resultQuery = await db.rawQuery(sql, args);
    return Refrigerator.toList(resultQuery);
  }

  updateRefrigeratorList(args) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${Refrigerator.tableName} 
      SET
        ${RefrigeratorField.name} = ? , 
        ${RefrigeratorField.count} = ?, 
        ${RefrigeratorField.regdate} = ?, 
        ${RefrigeratorField.expdate} = ? ,
        ${RefrigeratorField.position} = ? ,
        ${RefrigeratorField.memo} = ?
      WHERE
        ${RefrigeratorField.id} = ?
    ''';
    await db.transaction((txn) async {
      return await txn.rawUpdate(sql, args);
    });
  }

  deleteRefrigeratorList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${Refrigerator.tableName} WHERE ${RefrigeratorField.id} = '$id'
    ''';
    await db.rawDelete(sql);
  }
}
