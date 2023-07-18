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

  static List<CheckList> toList(List<Map> list) {
    return List.generate(list.length, (index) => mapToInstance(list[index]));
  }

  static CheckList mapToInstance(Map map) {
    String id = map[CheckListField.id].toString();
    String title = map[CheckListField.title].toString();
    String content = map[CheckListField.content].toString();
    String amount = map[CheckListField.amount].toString();
    String ischeck = map[CheckListField.ischeck].toString();
    return CheckList(
        id: int.parse(id),
        title: title,
        content: content,
        amount: int.parse(amount),
        ischeck: int.parse(ischeck).isEven ? false : true);
  }
}
