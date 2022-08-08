import 'dart:convert';

import '../generated/json/base/json_field.dart';
import '../generated/json/socket_entity.g.dart';

@JsonSerializable()
class SocketEntity {

	String? order;
	String? parsingData;
	String? result;
	String? type;
  
  SocketEntity();

  factory SocketEntity.fromJson(Map<String, dynamic> json) => $SocketEntityFromJson(json);

  Map<String, dynamic> toJson() => $SocketEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}