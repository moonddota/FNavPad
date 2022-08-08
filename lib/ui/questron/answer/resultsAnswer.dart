import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnavpad/bean/FlyResults.dart';
import 'package:fnavpad/bean/Questions.dart';
import 'package:fnavpad/bean/user.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:fnavpad/unit/CommUtils.dart'; //导入
import 'package:fnavpad/widget/topbar.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../res/SPConfig.dart';

class ResultsAnswerPage extends StatefulWidget {
  ResultsAnswerPage({Key? key}) : super(key: key);

  @override
  State<ResultsAnswerPage> createState() => _ResultsAnswerPageState();
}

class _ResultsAnswerPageState extends State<ResultsAnswerPage> {
  late Box flyResultsBox;

  @override
  void initState() {
    super.initState();
    initBox();
  }

  initBox() async {
    flyResultsBox = await Hive.openBox<FlyResults>(DBName.flyResults);
  }

  @override
  void dispose() {
    super.dispose();
    flyResultsBox.close();
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments as Map;
    var list = arg['list'] as List<QuestionsDetails>;
    var num = arg['num'] as int;
    List<QuestionsDetails> data = [];

    while (data.length < num) {
      int value = Random().nextInt(list.length);
      if (!data.contains(list[value])) {
        data.add(list[value]);
      }
    }
    return Material(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: MyColors.FFF4F7FD,
            child: Column(children: [
              TopBar(arg["name"], menuName: MyString.submit, menuClick: () {
                _sudmit(data);
              }),
              Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          _Item(index, data[index], (s) {
                            data[index].yourAnswer = s;
                          })))
            ])));
  }

  _sudmit(List<QuestionsDetails> data) {
    FlyResults flyResults = FlyResults.empty();
    int results = 0;
    int totalScore = 0;

    for (var i = 0; i < data.length; i++) {
      var it = data[i];
      if (it.yourAnswer.isEmpty) {
        Fluttertoast.showToast(msg: "请回答第${i + 1}题");
        return;
      }
      totalScore += it.score;
      it.yourAnswer = it.yourAnswer.sort();
      if (it.yourAnswer == it.reallyAnswer.toUpperCase().sort()) {
        results += it.score;
        it.yourScore = it.score;
      } else {
        it.yourScore = 0;
      }
    }
    String answerJson = jsonEncode(data);
    flyResults.answerQuestionsDetails = answerJson;
    flyResults.results = results;
    flyResults.totalScore = totalScore;
    flyResults.questionsNumber = data.length;
    flyResults.createTime = DateTime.now().toString();
    flyResults.soundRecordPatch = "";
    flyResults.className = data[0].className;
    flyResults.isSync = false;
    flyResults.soundRecordPatch = "";

    User user = getUser();
    flyResults.name = user.userName ?? "";
    flyResults.userId = user.id ?? "";
    print(flyResults);
    flyResultsBox.add(flyResults);
    Get.offAndToNamed(RoutePath.ResultsDetail,
        arguments: {"FlyResults": flyResults});
  }
}

class _Item extends StatefulWidget {
  int index;
  QuestionsDetails item;
  Function(String) changeAnswer;

  _Item(this.index, this.item, this.changeAnswer);

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with AutomaticKeepAliveClientMixin {
  String yourAnswer = "";
  String type = "";

  @override
  void initState() {
    yourAnswer = widget.item.yourAnswer;
    switch (widget.item.type) {
      case 1:
        type = "（判断题）";
        break;
      case 2:
        type = "（选择题）";
        break;
      default:
        type = "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.only(left: 25, top: 33, right: 25),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("第${widget.index + 1}题$type ${widget.item.score}分",
                style: const TextStyle(fontSize: 19, color: MyColors.FF666666)),
            Visibility(
                visible: widget.item.title.isNotEmpty,
                child: Column(children: [
                  const SizedBox(height: 21),
                  Text(widget.item.title,
                      style: const TextStyle(
                          color: MyColors.FF101010, fontSize: 19))
                ])),
            Visibility(
                visible: widget.item.body.isNotEmpty,
                child: Column(children: [
                  const SizedBox(height: 21),
                  Text(widget.item.body,
                      style: const TextStyle(
                          color: MyColors.FF101010, fontSize: 19))
                ])),
            const SizedBox(height: 25),
            Row(children: [
              const Text(MyString.answer,
                  style: TextStyle(color: MyColors.FF333333, fontSize: 19)),
              Expanded(
                  child: Row(
                children: [
                  Visibility(
                      visible: widget.item.type == 1,
                      child: Row(
                          children: ["对", "错"]
                              .map((e) => Row(
                                    children: [
                                      Radio<String>(
                                        groupValue: yourAnswer,
                                        value: e,
                                        onChanged: (String? value) {
                                          setState(() {
                                            yourAnswer = value ?? "";
                                          });
                                          widget.changeAnswer(value ?? "");
                                        },
                                      ),
                                      Text(e,
                                          style: const TextStyle(
                                              fontSize: 19,
                                              color: MyColors.FF333333))
                                    ],
                                  ))
                              .toList())),
                  Visibility(
                      visible: widget.item.type == 2,
                      child: Row(
                          children: ["A", "B", "C", "D", "E", "F"]
                              .map((e) => Row(
                                    children: [
                                      Checkbox(
                                        value: yourAnswer.contains(e),
                                        onChanged: (bool? value) {
                                          var s = (value ?? false)
                                              ? yourAnswer + e
                                              : yourAnswer.replaceAll(e, "");
                                          setState(() {
                                            yourAnswer = s;
                                          });
                                          widget.changeAnswer(s);
                                        },
                                      ),
                                      Text(e,
                                          style: const TextStyle(
                                              fontSize: 19,
                                              color: MyColors.FF333333))
                                    ],
                                  ))
                              .toList()))
                ],
              ))
            ]),
            const SizedBox(height: 15)
          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
