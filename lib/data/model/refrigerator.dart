import 'dart:math';

class RefrigeratorField {
  static final String id = 'id';
  static final String name = 'name';
  static final String count = 'count';
  static final String regdate = 'regdate';
  static final String expdate = 'expdate';
  static final String position = 'position';
  static final String memo = 'memo';
}

/// 식재료 모델클레스
class Refrigerator {
  Refrigerator({
    this.id,
    required this.name,
    required this.count,
    required this.regdate,
    required this.expdate,
    required this.position,
    this.memo,
  });
  static String tableName = "refrigerator";
  int? id; // PK
  String name; // 식재료명
  int count; // 수량
  String regdate; // 등록일자
  String expdate; // 유통기한
  String position; // 위치(냉장실, 냉동실, 신선칸)
  String? memo; // 메모

  static List<Refrigerator> toList(List<Map> list) {
    return List.generate(list.length, (index) => mapToInstance(list[index]));
  }

  static Refrigerator mapToInstance(Map data) {
    String id = data[RefrigeratorField.id].toString();
    String name = data[RefrigeratorField.name].toString();
    String count = data[RefrigeratorField.count].toString();
    String regdate = data[RefrigeratorField.regdate].toString();
    String expdate = data[RefrigeratorField.expdate].toString();
    String position = data[RefrigeratorField.position].toString();
    String memo = data[RefrigeratorField.memo].toString();
    return Refrigerator(
      id: int.parse(id),
      name: name,
      count: int.parse(count),
      regdate: regdate,
      expdate: expdate,
      position: position,
      memo: memo,
    );
  }
}
