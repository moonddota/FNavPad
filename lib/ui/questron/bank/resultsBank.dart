import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fnavpad/bean/Questions.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:fnavpad/widget/selectQuestionNumberDialog.dart';
import 'package:fnavpad/widget/topbar.dart';
import 'package:get/get.dart';

class ResultsBankPage extends StatefulWidget {
  ResultsBankPage({Key? key}) : super(key: key);

  @override
  State<ResultsBankPage> createState() => _ResultsBankPageState();
}

class _ResultsBankPageState extends State<ResultsBankPage> {
  List<_ResultsBank> list = [];

  List<_ResultsBankItem> colorsList = [
    _ResultsBankItem(0xff46a35c, "assets/images/q_bg_1.png"),
    _ResultsBankItem(0xffa35146, "assets/images/q_bg_2.png"),
    _ResultsBankItem(0xff6d46a3, "assets/images/q_bg_3.png"),
    _ResultsBankItem(0xffd78236, "assets/images/q_bg_4.png"),
    _ResultsBankItem(0xff7d67ee, "assets/images/q_bg_5.png"),
    _ResultsBankItem(0xff57b9e2, "assets/images/q_bg_6.png")
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    SmartDialog.showLoading();
    var value = await rootBundle.loadString("assets/json/Questions.json");
    List<_ResultsBank> data = [];
    final map = json.decode(value);
    final questions = Questions.fromJson(map);
    questions.nlist.forEach((name) {
      final qs = questions.qlist.where((it) => it.className == name);
      if (qs.isNotEmpty) {
        data.add(_ResultsBank(name, qs.toList()));
      }
    });
    setState(() {
      list.addAll(data);
      SmartDialog.dismiss(status: SmartStatus.loading);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
        TopBar(MyString.selectBlank, menuName: "列表", menuClick: () {
          Get.toNamed(RoutePath.ResultsRecord);
        }),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 25,
                            mainAxisExtent: 215),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _getItem(index);
                    })))
      ]),
    );
  }

  _getItem(int index) {
    _ResultsBank item = list[index];
    _ResultsBankItem pair = colorsList[index % 6];
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (ctx) =>
                  SelectQuestionNumberDialog(item.list.length, (num) {
                    Get.offAndToNamed(RoutePath.ResultsAnswer, arguments: {
                      "name": item.name,
                      "num": num,
                      "list": item.list
                    });
                  }));
        },
        child: Column(
          children: [
            Container(
              width: 200,
              height: 160,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(pair.imageUrl), fit: BoxFit.fill)),
              child: Column(children: [
                const SizedBox(height: 40),
                Text(item.name,
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
                const SizedBox(height: 50),
                Text(item.list.length.toString(),
                    style: TextStyle(fontSize: 16, color: Color(pair.color)))
              ]),
            ),
            const SizedBox(height: 16),
            Text(item.name,
                style: const TextStyle(color: MyColors.FF101010, fontSize: 16)),
            const SizedBox(height: 16),
          ],
        ));
  }
}

class _ResultsBankItem {
  int color;
  String imageUrl;
  _ResultsBankItem(this.color, this.imageUrl);
}

class _ResultsBank {
  String name;
  List<QuestionsDetails> list;
  _ResultsBank(this.name, this.list);
}
