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

  Map toJson() {
    return {
      'title': title,
      'regdate': regdate,
      'isdone': isdone,
    };
  }

  factory Shopping.fromJson(json) {
    return Shopping(
      title: json['title'],
      regdate: json['regdate'],
      isdone: json['isdone'],
    );
  }
}
