import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnavpad/bean/FlyResults.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/widget/topbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../res/SPConfig.dart';

class ResultsRecordPage extends StatefulWidget {
  ResultsRecordPage({Key? key}) : super(key: key);

  @override
  State<ResultsRecordPage> createState() => _ResultsRecordPageState();
}

class _ResultsRecordPageState extends State<ResultsRecordPage> {
  List<_FlyResultNames> list = [];

  late Box flyResultsBox;

  @override
  void initState() {
    super.initState();
    initBox();
  }

  initBox() async {
    flyResultsBox = await Hive.openBox<FlyResults>(DBName.flyResults);
    var fs = flyResultsBox.values;
    for (var e in fs) {
      var find = list.where((element) => element.name == e.name);
      if (find.isEmpty) {
        var f = _FlyResultNames(e.name);
        f.child.insert(0, e);
        list.add(f);
      } else {
        find.toList()[0].child.insert(0, e);
      }
    }
    setState(() {
      list;
    });
  }

  @override
  void dispose() {
    super.dispose();
    flyResultsBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColors.FFF4F7FD,
      child: Column(
        children: [
          TopBar("飞行测问"),
          Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: ((context, index) => Container(
                      color: Colors.white,
                      child: ExpansionTile(
                          title: Text(list[index].name,
                              style: const TextStyle(
                                  color: MyColors.FF101010, fontSize: 16)),
                          children: list[index]
                              .child
                              .map((e) => InkWell(
                                  onTap: () {
                                    Get.toNamed(RoutePath.ResultsDetail,
                                        arguments: {"FlyResults": e});
                                  },
                                  child: Container(
                                      width: double.infinity,
                                      height: 65,
                                      color: Colors.white,
                                      child: Column(children: [
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: MyColors.FFF4F7FD,
                                        ),
                                        Expanded(
                                            child: Row(
                                          children: [
                                            const SizedBox(width: 50),
                                            Text(
                                                "${e.className}${e.questionsNumber}道",
                                                style: const TextStyle(
                                                    color: MyColors.FF333333,
                                                    fontSize: 16)),
                                            const SizedBox(width: 17),
                                            Text(e.createTime,
                                                style: const TextStyle(
                                                    color: MyColors.FFa3a3a3,
                                                    fontSize: 16)),
                                            const Spacer(),
                                            Text(e.results.toString(),
                                                style: TextStyle(
                                                    color: (e.results /
                                                                e.totalScore >
                                                            0.6)
                                                        ? MyColors.FF3487f3
                                                        : MyColors.FFda5121,
                                                    fontSize: 21)),
                                            const SizedBox(width: 35),
                                          ],
                                        ))
                                      ]))))
                              .toList())))))
        ],
      ),
    );
  }
}

class _FlyResultNames {
  String name;
  List<FlyResults> child = [];

  _FlyResultNames(this.name);
}
