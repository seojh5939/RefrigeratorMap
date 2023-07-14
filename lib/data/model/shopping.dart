/// 장보기 목록 모델클레스
class Shopping {
  Shopping({
    required this.title,
    required this.dttm,
    this.isCompleted = false,
    this.isDone = false,
    required this.content,
    this.amount = 0,
  });
  String title; // 장보기 목록 제목
  String dttm; // 장보기 일시
  bool isCompleted; // 체크박스 체크여부
  bool isDone; // 장보기 완료여부
  String content; // 장보기 목록에 들어가는 내용
  int amount; // 사용한 금액

  Map toJson() {
    return {
      'title': title,
      'dttm': dttm,
      'isCompleted': isCompleted,
      'isDone': isDone,
      'content': content,
      'amount': amount,
    };
  }

  factory Shopping.fromJson(json) {
    return Shopping(
        title: json['title'],
        dttm: json['dttm'],
        isCompleted: json['isCompleted'],
        isDone: json['isDone'],
        content: json['content'],
        amount: json['amount']);
  }
}
