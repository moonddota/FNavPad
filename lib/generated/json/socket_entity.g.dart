
import '../../bean/socket_entity.dart';
import 'base/json_convert_content.dart';

SocketEntity $SocketEntityFromJson(Map<String, dynamic> json) {
	final SocketEntity socketEntity = SocketEntity();
	final String? order = jsonConvert.convert<String>(json['order']);
	if (order != null) {
		socketEntity.order = order;
	}
	final String? parsingData = jsonConvert.convert<String>(json['parsingData']);
	if (parsingData != null) {
		socketEntity.parsingData = parsingData;
	}
	final String? result = jsonConvert.convert<String>(json['result']);
	if (result != null) {
		socketEntity.result = result;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		socketEntity.type = type;
	}
	return socketEntity;
}

Map<String, dynamic> $SocketEntityToJson(SocketEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['order'] = entity.order;
	data['parsingData'] = entity.parsingData;
	data['result'] = entity.result;
	data['type'] = entity.type;
	return data;
}