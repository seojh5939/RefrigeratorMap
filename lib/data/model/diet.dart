/// 식단표 모델클레스
class Diet {
  Diet(
      {this.id,
      required this.name,
      required this.date,
      required this.mealTime,
      this.memo = ""});
  int? id; // pk
  String name; // 음식명
  String date; // 날짜
  String mealTime; // 언제먹을지(아침,점심,저녁,간식)
  String memo; // 메모
}
