/// 식재료 모델클레스
class Refrigerator {
  Refrigerator({
    this.id,
    required this.name,
    required this.count,
    required this.regDate,
    required this.expDate,
    required this.position,
    this.memo,
  });
  int? id; // PK
  String name; // 식재료명
  int count; // 수량
  String regDate; // 등록일자
  String expDate; // 유통기한
  String position; // 위치(냉장실, 냉동실, 신선칸)
  String? memo; // 메모
}
