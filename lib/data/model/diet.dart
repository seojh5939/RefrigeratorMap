class DietField {
  static final String id = 'id';
  static final String name = 'name';
  static final String date = 'date';
  static final String mealtime = 'mealtime';
  static final String memo = 'memo';
}

/// 식단표 모델클레스
class Diet {
  Diet({
    this.id,
    required this.name,
    required this.date,
    required this.mealtime,
    required this.memo,
  });
  static String tableName = "diet";
  int? id;
  String name; // 음식명
  String date; // 날짜
  String mealtime; // 언제먹을지(아침,점심,저녁,간식)
  String memo; // 메모

  static toList(List<Map> list) {
    return List.generate(list.length, (index) => list[index]);
  }

  static Diet mapToInstance(Map data) {
    String id = data[DietField.id];
    String name = data[DietField.name];
    String date = data[DietField.date];
    String mealtime = data[DietField.mealtime];
    String memo = data[DietField.memo];
    return Diet(
      id: int.parse(id),
      name: name,
      date: date,
      mealtime: mealtime,
      memo: memo,
    );
  }
}
