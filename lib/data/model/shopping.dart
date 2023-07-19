class ShoppingField {
  static final String id = 'id';
  static final String title = 'title';
  static final String regdate = 'regdate';
  static final String isdone = 'isdone';
}

/// 장보기 목록 모델클레스
class Shopping {
  Shopping({
    this.id,
    required this.title,
    required this.regdate,
    this.isdone = false,
  });
  static String tableName = "shopping";
  int? id;
  String title; // 장보기 목록 제목
  String regdate; // 장보기 일시
  bool isdone; // 장보기 완료여부

  static toList(List<Map> list) {
    return List.generate(list.length, (index) => mapToInstance(list[index]));
  }

  static Shopping mapToInstance(Map map) {
    String id = map[ShoppingField.id].toString();
    String title = map[ShoppingField.title].toString();
    String regdate = map[ShoppingField.regdate].toString();
    String isdone = map[ShoppingField.isdone].toString();
    return Shopping(
      id: int.parse(id),
      title: title,
      regdate: regdate,
      isdone: int.parse(isdone).isEven ? false : true,
    );
  }
}
