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

  static List<MuckitList> toList(List<Map> list) {
    return List.generate(list.length, (index) => mapToInstance(list[index]));
  }

  static MuckitList mapToInstance(Map data) {
    String id = data[MuckitListField.id].toString();
    String name = data[MuckitListField.name].toString();
    String date = data[MuckitListField.date].toString();
    return MuckitList(
      id: int.parse(id),
      name: name,
      date: date,
    );
  }
}
