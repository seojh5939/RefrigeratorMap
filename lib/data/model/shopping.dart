/// 장보기 목록 모델클레스
class Shopping {
  Shopping({
    this.isCompleted = false,
    required this.content,
    this.amount = 0,
  });
  bool isCompleted; // 완료박스 체크여부
  String content; // 장보기 목록에 들어가는 내용
  int amount; // 사용한 금액

  Map toJson() {
    return {
      'isCompleted': isCompleted,
      'content': content,
      'amount': amount,
    };
  }

  factory Shopping.fromJson(json) {
    return Shopping(
        isCompleted: json['isCompleted'],
        content: json['content'],
        amount: json['amount']);
  }
}
