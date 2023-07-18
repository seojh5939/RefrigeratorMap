class DBHelper {
  static final _db = DBHelper._internal();

  DBHelper._internal();

  static DBHelper get instance => _db;

  factory DBHelper() => instance;
}
