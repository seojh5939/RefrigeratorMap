import 'package:refrigerator_map/data/db/db_helper.dart';
import 'package:refrigerator_map/data/model/checklist.dart';

class CheckListService {
  addCheckList(CheckList data) async {
    var db = await DBHelper.instance.database;
    db.transaction(
      (txn) async {
        String sql = '''
          INSERT INTO ${CheckList.tableName}(
            ${CheckListField.id},
            ${CheckListField.title},
            ${CheckListField.content},
            ${CheckListField.amount},
            ${CheckListField.ischeck}
            ) VALUES(?, ?, ?, ?)
          ''';
        await db.transaction(
          (txn) async {
            return await txn.rawInsert(
                sql, [data.title, data.content, data.amount, data.ischeck]);
          },
        );
      },
    );
  }

  Future<List<CheckList>> getShoppingCheckList(String title) async {
    var db = await DBHelper.instance.database;
    String sql = '''
    SELECT 
      ${CheckListField.id},
      ${CheckListField.title},
      ${CheckListField.content},
      ${CheckListField.amount},
      ${CheckListField.ischeck}
      from ${CheckList.tableName}
      where ${CheckListField.title} = $title
    ''';
    var args = [];
    List<Map> result = await db.transaction(
      (txn) async {
        return await db.rawQuery(sql, args);
      },
    );

    return CheckList.toList(result);
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
    await db.transaction(
      (txn) async {
        return await db.rawUpdate(sql, args);
      },
    );
  }

  deleteCheckList(int id) async {
    var db = await DBHelper.instance.database;
    String sql = '''
      DELETE FROM ${CheckList.tableName} WHERE $id = ?
    ''';
    db.rawDelete(sql);
  }
}
