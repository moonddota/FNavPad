import 'package:flutter/material.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/widget/topbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../widget/gradient_color_button/view.dart';
import 'logic.dart';

class DataSyncPage extends StatefulWidget {
  @override
  _DataSyncPageState createState() => _DataSyncPageState();
}

class _DataSyncPageState extends State<DataSyncPage> {
  final logic = Get.put(DataSyncLogic());
  final state = Get.find<DataSyncLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TopBar("数据同步"),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/sync_bg.png"))),
            child: Column(children: [
              const SizedBox(height: 160),
              Obx(() => Text(state.progress.value,
                  style:
                      const TextStyle(color: MyColors.FF101010, fontSize: 30))),
              const SizedBox(height: 400),
              Obx(() => GradientColorButtonWidget(state.progress.value, () {
                    logic.sendMsg();
                  }, buttonEnablel: state.buttonEnablel.value))
            ]),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<DataSyncLogic>();
    super.dispose();
  }
}
