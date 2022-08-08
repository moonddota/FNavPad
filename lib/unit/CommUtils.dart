// ignore_for_file: unnecessary_this

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import '../bean/user.dart';
import '../res/SPConfig.dart';

extension StringExtension1 on String {
  String sort() {
    List<String> a = this.characters.toList();
    a.sort();
    var b = a.join("");
    return b;
  }
}


User getUser() {
  final _box = GetStorage();
  String s = _box.read(SPConfig.user) ?? "";
  final map = json.decode(s);
  User user = User.fromJson(map);
  return user;
}
