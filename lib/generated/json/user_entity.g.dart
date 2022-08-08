
import '../../bean/user.dart';
import 'base/json_convert_content.dart';

User $UserEntityFromJson(Map<String, dynamic> json) {
	final User userEntity = User();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userEntity.id = id;
	}
	final int? userType = jsonConvert.convert<int>(json['userType']);
	if (userType != null) {
		userEntity.userType = userType;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userEntity.name = name;
	}
	final String? userName = jsonConvert.convert<String>(json['userName']);
	if (userName != null) {
		userEntity.userName = userName;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userEntity.password = password;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		userEntity.createTime = createTime;
	}
	final String? createPeople = jsonConvert.convert<String>(json['createPeople']);
	if (createPeople != null) {
		userEntity.createPeople = createPeople;
	}
	final String? tag = jsonConvert.convert<String>(json['tag']);
	if (tag != null) {
		userEntity.tag = tag;
	}
	final bool? isSync = jsonConvert.convert<bool>(json['isSync']);
	if (isSync != null) {
		userEntity.isSync = isSync;
	}
	final String? group = jsonConvert.convert<String>(json['group']);
	if (group != null) {
		userEntity.group = group;
	}
	final String? codeName = jsonConvert.convert<String>(json['code_name']);
	if (codeName != null) {
		userEntity.codeName = codeName;
	}
	final String? nativePlace = jsonConvert.convert<String>(json['native_place']);
	if (nativePlace != null) {
		userEntity.nativePlace = nativePlace;
	}
	final String? nation = jsonConvert.convert<String>(json['nation']);
	if (nation != null) {
		userEntity.nation = nation;
	}
	final String? joinTheArmyDate = jsonConvert.convert<String>(json['join_the_army_date']);
	if (joinTheArmyDate != null) {
		userEntity.joinTheArmyDate = joinTheArmyDate;
	}
	final String? joinThePartyDate = jsonConvert.convert<String>(json['join_the_party_date']);
	if (joinThePartyDate != null) {
		userEntity.joinThePartyDate = joinThePartyDate;
	}
	final String? joinTheCollegeDate = jsonConvert.convert<String>(json['join_the_college_date']);
	if (joinTheCollegeDate != null) {
		userEntity.joinTheCollegeDate = joinTheCollegeDate;
	}
	final String? educationBackground = jsonConvert.convert<String>(json['education_background']);
	if (educationBackground != null) {
		userEntity.educationBackground = educationBackground;
	}
	final String? dateOfBirth = jsonConvert.convert<String>(json['date_of_birth']);
	if (dateOfBirth != null) {
		userEntity.dateOfBirth = dateOfBirth;
	}
	return userEntity;
}

Map<String, dynamic> $UserEntityToJson(User entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['userType'] = entity.userType;
	data['name'] = entity.name;
	data['userName'] = entity.userName;
	data['password'] = entity.password;
	data['createTime'] = entity.createTime;
	data['createPeople'] = entity.createPeople;
	data['tag'] = entity.tag;
	data['isSync'] = entity.isSync;
	data['group'] = entity.group;
	data['code_name'] = entity.codeName;
	data['native_place'] = entity.nativePlace;
	data['nation'] = entity.nation;
	data['join_the_army_date'] = entity.joinTheArmyDate;
	data['join_the_party_date'] = entity.joinThePartyDate;
	data['join_the_college_date'] = entity.joinTheCollegeDate;
	data['education_background'] = entity.educationBackground;
	data['date_of_birth'] = entity.dateOfBirth;
	return data;
}