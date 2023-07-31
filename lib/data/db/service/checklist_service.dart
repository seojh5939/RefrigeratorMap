import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/checklist.dart';

class CheckListService {
  addCheckList(CheckList data) async {
    var db = await DBHelper.instance.database;
    String sql = '''
          INSERT INTO ${CheckList.tableName}(
            ${CheckListField.title},
            ${CheckListField.content},
            ${CheckListField.amount},
            ${CheckListField.ischeck}
            ) VALUES(?, ?, ?, ?)
          ''';
    db.transaction((txn) async {
      return await txn.rawInsert(sql, [
        data.title,
        data.content,
        data.amount,
        data.ischeck == false ? 0 : 1
      ]);
    });
  }

  Future<List<CheckList>> getShoppingCheckListByTitle(String title) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    SELECT 
      ${CheckListField.id},
      ${CheckListField.title},
      ${CheckListField.content},
      ${CheckListField.amount},
      ${CheckListField.ischeck}
      from ${CheckList.tableName}
      where ${CheckListField.title} = '$title'
    ''';
    var args = [];
    List<Map> result = await db.transaction(
      (txn) async {
        return await txn.rawQuery(sql, args);
      },
    );

    return CheckList.toList(result);
  }

  Future<CheckList> getShoppingCheckListById(int id, String title) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    SELECT 
      ${CheckListField.id},
      ${CheckListField.title},
      ${CheckListField.content},
      ${CheckListField.amount},
      ${CheckListField.ischeck}
      FROM ${CheckList.tableName}
      WHERE ${CheckListField.title} = '$title' AND ${CheckListField.id} = '${id.toString()}'
    ''';
    var args = [];
    List<Map>? result = await db.rawQuery(sql, args);
    return CheckList.toList(result).first;
  }

  updateCheckList(List args) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${CheckList.tableName} 
      SET
        ${CheckListField.content} = ? , ${CheckListField.amount} = ?, ${CheckListField.ischeck} = ?
      WHERE
        ${CheckListField.id} = ?
    ''';
    await db.rawUpdate(sql, args);
  }

  updateCheckState(int ischeck, int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    UPDATE
        ${CheckList.tableName} 
      SET
        ${CheckListField.ischeck} = ?
      WHERE
        ${CheckListField.id} = ?
    ''';
    await db.transaction((txn) async {
      return await txn.rawUpdate(sql, [ischeck, id]);
    });
  }

  deleteCheckList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${CheckList.tableName} WHERE ${CheckListField.id} = '$id'
    ''';
    await db.rawDelete(sql);
  }
}
