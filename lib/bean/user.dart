import 'package:hive/hive.dart';
import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/user_entity.g.dart';

part 'user.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User extends HiveObject{
  @HiveField(0)
  String? id;
  @HiveField(1)
  int? userType;     // 用户等级  0 普通用户 1.高级用户  2 管理员
  @HiveField(2)
  String? name;        //名字
  @HiveField(3)
  String? userName;    // 昵称
  @HiveField(4)
  String? password;
  @HiveField(5)
  String? createTime;   //创建时间
  @HiveField(6)
  String? createPeople; //  创建人
  @HiveField(7)
  String? tag;    //  预留字段
  @HiveField(8)
  bool? isSync;  //是否同步了
  @HiveField(9)
  String? group; //  编组
  @HiveField(10)
  @JSONField(name: "code_name")
  @HiveField(11)
  String? codeName;  //代号
  @JSONField(name: "native_place")
  @HiveField(12)
  String? nativePlace;  //籍贯
  @HiveField(13)
  String? nation;  //民族
  @JSONField(name: "join_the_army_date")
  @HiveField(14)
  String? joinTheArmyDate;//入伍日期
  @JSONField(name: "join_the_party_date")
  @HiveField(15)
  String? joinThePartyDate;//入党日期
  @JSONField(name: "join_the_college_date")
  @HiveField(16)
  String? joinTheCollegeDate; //入学院日期
  @JSONField(name: "education_background")
  @HiveField(17)
  String? educationBackground; //学历
  @HiveField(18)
  String? dateOfBirth; //出生日期

  User();

  factory User.fromJson(Map<String, dynamic> json) => $UserEntityFromJson(json);

  Map<String, dynamic> toJson() => $UserEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}
