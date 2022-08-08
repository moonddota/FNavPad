import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnavpad/bean/FlyResults.dart';
import 'package:fnavpad/bean/Questions.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:get/get.dart';
import 'package:fnavpad/unit/CommUtils.dart'; //导入

class ResultsDetailsPage extends StatefulWidget {
  ResultsDetailsPage({Key? key}) : super(key: key);

  @override
  State<ResultsDetailsPage> createState() => _ResultsDetailsPageState();
}

class _ResultsDetailsPageState extends State<ResultsDetailsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments as Map;
    var data = arg['FlyResults'] as FlyResults;
    var answerString = data.answerQuestionsDetails;
    var list = json.decode(answerString) as List;
    var dataList = list.map((e) => QuestionsDetails.fromJson(e)).toList();

    return Material(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: MyColors.FFF4F7FD,
          child: Column(children: [
            Container(
                width: double.infinity,
                height: 261,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 261,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/results_details_title_bg.png"))),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.all(25),
                                        child: Image(
                                          image: AssetImage(
                                              "assets/images/icon_back.png"),
                                          width: 12,
                                          height: 21,
                                        ),
                                      ))),
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 35),
                                    child: Column(
                                      children: [
                                        const Image(
                                            width: 90,
                                            height: 90,
                                            image: AssetImage(
                                                "assets/images/my_avatar.png")),
                                        const SizedBox(height: 12),
                                        Text(getUser().userName??"",
                                            style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white))
                                      ],
                                    )),
                              )
                            ],
                          ),
                        )),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 550,
                          height: 88,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(data.results.toString(),
                                      style: const TextStyle(
                                          color: MyColors.FFE59203,
                                          fontSize: 25)),
                                  const Text("考试得分",
                                      style: TextStyle(
                                          color: MyColors.FF888888,
                                          fontSize: 13))
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(data.totalScore.toString(),
                                      style: const TextStyle(
                                          color: MyColors.FF6297EC,
                                          fontSize: 25)),
                                  const Text("试卷总分",
                                      style: TextStyle(
                                          color: MyColors.FF888888,
                                          fontSize: 13))
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text("考试时间",
                                      style: TextStyle(
                                          color: MyColors.FF888888,
                                          fontSize: 16)),
                                  Text(data.createTime,
                                      style: TextStyle(
                                          color: MyColors.FF888888,
                                          fontSize: 13))
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) =>
                    _getItem(index, dataList[index]),
              ),
            )
          ])),
    );
  }
}

_getItem(int index, QuestionsDetails item) {
  var type = "";
  switch (item.type) {
    case 1:
      type = "（判断题）";
      break;
    case 2:
      type = "（选择题）";
      break;
    default:
      type = "";
  }

  return Container(
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(25),
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("第${index + 1}题$type ${item.score.toString().sort()}分",
                style: const TextStyle(color: MyColors.FF666666, fontSize: 19)),
            Visibility(
                visible:
                    item.yourAnswer == item.reallyAnswer.toUpperCase().sort(),
                replacement: const Text("回答错误",
                    style: TextStyle(color: MyColors.FFda5121, fontSize: 19)),
                child: const Text("回答正确",
                    style: TextStyle(color: MyColors.FF35AF77, fontSize: 19))),
          ],
        ),
        const SizedBox(height: 12),
        Visibility(
            visible: item.title.isNotEmpty,
            child: Text(item.title,
                style:
                    const TextStyle(color: MyColors.FF101010, fontSize: 19))),
        Visibility(
            visible: item.body.isNotEmpty,
            child: Text(item.body,
                style:
                    const TextStyle(color: MyColors.FF101010, fontSize: 19))),
        const SizedBox(height: 25),
        Row(
          children: [
            Text("你的答案：${item.yourAnswer}",
                style: TextStyle(color: MyColors.FF888888, fontSize: 19)),
            const SizedBox(width: 23),
            Text("正确答案：${item.reallyAnswer}",
                style: TextStyle(color: MyColors.FF101010, fontSize: 19)),
          ],
        )
      ],
    ),
  );
}
