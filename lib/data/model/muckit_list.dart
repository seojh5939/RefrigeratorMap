class MuckitListField {
  static final String id = 'id';
  static final String name = 'name';
  static final String date = 'date';
}

class MuckitList {
  MuckitList({
    this.id,
    required this.name,
    required this.date,
  });
  static String tableName = "muckitlist";
  int? id;
  String name; // 식사명
  String date; // 날짜
}
