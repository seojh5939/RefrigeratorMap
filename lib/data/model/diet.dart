/// 식단표 모델클레스
class Diet {
  Diet(
      {required this.name,
      required this.date,
      required this.time,
      this.memo = ""});
  String name; // 음식명
  String date; // 날짜
  String time; // 언제먹을지(아침,점심,저녁,간식)
  String memo; // 메모
}
