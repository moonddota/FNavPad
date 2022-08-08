class Questions {
  List<String> nlist;
  List<QuestionsDetails> qlist;

  Questions(this.nlist, this.qlist);

  factory Questions.fromJson(Map<String, dynamic> json) {
    final old = json['nlist'];
    List<String> nlist = List<String>.from(old);

    final originList = json['qlist'] as List;
    List<QuestionsDetails> qlist =
        originList.map((value) => QuestionsDetails.fromJson(value)).toList();
    return Questions(nlist, qlist);
  }
}

class QuestionsDetails {
  int id;
  int type; // 1 判断题   2 选择题   // 3、论述题(答案口述)
  String yourAnswer; //  你的答案
  String reallyAnswer; // 正确答案
  String body; // 题目
  String title; //标题
  int score; //分值
  int? yourScore; //你的分值
  String className;

  QuestionsDetails(this.id, this.type, this.yourAnswer, this.reallyAnswer,
      this.body, this.title, this.score, this.yourScore, this.className);

  factory QuestionsDetails.fromJson(Map<String, dynamic> json) {
    return QuestionsDetails(
      json['id'],
      json['type'],
      json["yourAnswer"],
      json["reallyAnswer"],
      json["body"],
      json["title"],
      json["score"],
      json["yourScore"],
      json["className"],
    );
  }

  Map toJson() {
    Map map = {};
    map["id"] = id;
    map["type"] = type;
    map["yourAnswer"] = yourAnswer;
    map["reallyAnswer"] = reallyAnswer;
    map["body"] = body;
    map["title"] = title;
    map["score"] = score;
    map["yourScore"] = yourScore;
    map["className"] = className;
    return map;
  }
}
