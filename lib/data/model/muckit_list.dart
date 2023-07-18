class MuckitList {
  MuckitList({
    this.id,
    required this.name,
    required this.date,
  });
  int? id; // PK
  String name; // 식사명
  String date; // 날짜
}
