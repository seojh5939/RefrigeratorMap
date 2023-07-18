class CheckListField {
  static final String id = 'id';
  static final String title = 'title';
  static final String content = 'content';
  static final String amount = 'amount';
  static final String ischeck = 'ischeck';
}

class CheckList {
  CheckList({
    this.id,
    required this.title,
    required this.content,
    required this.amount,
    required this.ischeck,
  });
  static String tableName = "checklist";
  int? id;
  String title; // 쇼핑목록 타이틀
  String content; // 장보기 목록에 들어가는 내용
  int amount; // 사용한 금액
  bool ischeck; // 체크박스 체크여부
}
