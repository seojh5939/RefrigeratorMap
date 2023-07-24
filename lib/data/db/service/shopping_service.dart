import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/shopping.dart';

class ShoppingService {
  addShoppingList(Shopping data) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      INSERT INTO ${Shopping.tableName}(
            ${ShoppingField.title},
            ${ShoppingField.regdate},
            ${ShoppingField.isdone}
            ) VALUES(?, ?, ?)
    ''';
    await db.rawInsert(
        sql, [data.title, data.regdate, data.isdone == false ? 0 : 1]);
  }

  // 전체 조회
  Future<List<Shopping>> getAllShoppingList() async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Shopping.tableName}
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return Shopping.toList(result);
  }

  Future<List<Shopping>> getDateShoppingList(String date) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      SELECT * FROM ${Shopping.tableName} WHERE ${ShoppingField.regdate} = '$date'
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return Shopping.toList(result);
  }

  updateShoppingList(args) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${Shopping.tableName} 
      SET
        ${ShoppingField.title} = ? , ${ShoppingField.regdate} = ?, ${ShoppingField.isdone} = ?
      WHERE
        ${ShoppingField.id} = ?
    ''';
    await db.transaction((txn) async {
      return await txn.rawUpdate(sql, args);
    });
  }

  deleteShoppingList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${Shopping.tableName} WHERE ${ShoppingField.id} = '$id'
    ''';
    await db.rawDelete(sql);
  }
}
