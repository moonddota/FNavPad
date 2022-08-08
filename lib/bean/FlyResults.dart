import 'package:hive/hive.dart';
part 'FlyResults.g.dart';

@HiveType(typeId: 2)
class FlyResults {
  @HiveField(0)
  late String createTime; //考试时间
  @HiveField(1)
  late String name; //姓名
  @HiveField(2)
  late String userId; //用户id
  @HiveField(3)
  late int results; //成绩
  @HiveField(4)
  late int questionsNumber; //题目数量
  @HiveField(5)
  late int totalScore; //总得分
  @HiveField(6)
  late String answerQuestionsDetails; //答题详情
  @HiveField(7)
  late String className; //类目名称
  @HiveField(8)
  bool isSync = false;
  @HiveField(9)
  String soundRecordPatch = "";

  FlyResults(
      this.createTime,
      this.name,
      this.userId,
      this.results,
      this.questionsNumber,
      this.totalScore,
      this.answerQuestionsDetails,
      this.className,
      this.isSync,
      this.soundRecordPatch);
  FlyResults.empty();

  factory FlyResults.fromJson(Map<String, dynamic> json) {
    return FlyResults(
      json['createTime'],
      json['name'],
      json["userId"],
      json["results"],
      json["questionsNumber"],
      json["totalScore"],
      json["answerQuestionsDetails"],
      json["className"],
      json["isSync"],
      json["soundRecordPatch"],
    );
  }

  Map toJson() {
    Map map = {};
    map['createTime'] = createTime;
    map['name'] = name;
    map["userId"] = userId;
    map["results"] = results;
    map["questionsNumber"] = questionsNumber;
    map["totalScore"] = totalScore;
    map["answerQuestionsDetails"] = answerQuestionsDetails;
    map["className"] = className;
    map["isSync"] = isSync;
    map["soundRecordPatch"] = soundRecordPatch;
    return map;
  }

  @override
  String toString() {
    return 'FlyResults{createTime: $createTime, name: $name, userId: $userId, results: $results, questionsNumber: $questionsNumber, totalScore: $totalScore, answerQuestionsDetails: $answerQuestionsDetails, className: $className, isSync: $isSync, soundRecordPatch: $soundRecordPatch}';
  }
}
