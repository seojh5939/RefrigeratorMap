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
}
