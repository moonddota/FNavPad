import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fnavpad/bean/socket_entity.dart';
import 'package:fnavpad/bean/user.dart';
import 'package:fnavpad/res/SPConfig.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../bean/FlyResults.dart';
import '../../unit/SocketManage.dart';
import 'state.dart';

class DataSyncLogic extends GetxController {
  final DataSyncState state = DataSyncState();

  @override
  void onReady() {
    super.onReady();
    SocketManage.instance.serverBind(SocketCallback(onConnect: () {
      state.buttonEnablel.value = true;
    }, onDone: () {
      SmartDialog.showToast("连接断开");
      state.buttonEnablel.value = false;
    }, receiveMessage: (String msg) async {
      dataProcessing(msg);
    }));
  }

  @override
  void onClose() {
    super.onClose();
    SocketManage.instance.close();
  }

  sendMsg() {
    SocketManage.instance.sendMsg("I am Flutter");
  }

  dataProcessing(String msg) async {
    final entity = SocketEntity.fromJson(json.decode(msg));
    if (entity.result != "ok") return;
    switch (entity.order) {
      // 询问
      case "0":
        switch (entity.type) {
          //用户
          case "1":
            _userProcessing(entity.parsingData ?? "");
            break;
        }
        break;
      // 回答
      case "1":
        break;
    }
  }

  _userProcessing(String msg) async {
    if (msg.isEmpty) return;
    Box userBox = await Hive.openBox<User>(DBName.user);
    List<dynamic> datas = json.decode(msg);
    List<User> list = datas.map((e) => User.fromJson(e)).toList();
    await userBox.clear();
    await userBox.addAll(list);
    await userBox.close();
    state.progress.value = "用户同步完成";

    Box flyResultsBox = await Hive.openBox<FlyResults>(DBName.flyResults);
    var fs = flyResultsBox.values.toList() as List<FlyResults>;
    var fss = [];
    for (var i = 0; i < fs.length; i++) {
      var e = fs[i];
      if (!e.isSync) {
        fss.add(e);
        await flyResultsBox.putAt(i, e..isSync = true);
      }
    }
    flyResultsBox.close();
    final data = SocketEntity()
      ..type = "2"
      ..result = "ok"
      ..parsingData = jsonEncode(fss)
      ..order = "1";
    SocketManage.instance.sendMsg(jsonEncode(data));
  }
}
