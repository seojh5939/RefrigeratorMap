/// 식재료 모델클레스
class Refrigerator {
  Refrigerator({
    required this.name,
    this.count = 1,
    required this.regDate,
    required this.expDate,
    required this.location,
    this.memo = "",
  });
  String name; // 식재료명
  int count; // 수량
  String regDate; // 등록일자
  String expDate; // 유통기한
  String location; // 위치(냉장실, 냉동실, 신선칸)
  String memo; // 메모
}
