import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnavpad/bean/user.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:fnavpad/unit/CommUtils.dart';
import 'package:fnavpad/widget/twoButtonTipDialog.dart';
import 'package:get/get.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 326,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/my_title_bg.png"),
                  fit: BoxFit.fill)),
          child: Column(children: [
            const SizedBox(height: 78),
            const Image(
                width: 90,
                height: 90,
                image: AssetImage("assets/images/my_avatar.png")),
            const SizedBox(height: 12),
            Text(
              getUser().userName??"",
              style: const TextStyle(fontSize: 18, color: Colors.white),
            )
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        _getItem("用户管理", "assets/images/my_management_user.png", () {
          Fluttertoast.showToast(msg: "用户管理");
        }),
        _getItem("关于", "assets/images/my_about.png", () {
          Fluttertoast.showToast(msg: "关于");
        }),
        _getItem("切换用户", "assets/images/my_switch_account.png", () {
          showDialog(
              context: context,
              builder: (ctx) => TwoButtonTipDialog(MyString.switchAccount, () {
                    Get.offAllNamed(RoutePath.Login);
                  }));
        }),
        _getItem(
          "退出登录",
          "assets/images/my_exit.png",
          () {
            showDialog(
                context: context,
                builder: (ctx) => TwoButtonTipDialog(MyString.exitApp, () {
                      Get.back();
                      exit(0);
                    }));
          },
        ),
      ],
    );
  }
}

_getItem(String name, String url, Function block) {
  return InkWell(
    onTap: () {
      block();
    },
    child: Container(
        width: double.infinity,
        height: 83,
        padding: const EdgeInsets.only(left: 73, right: 91),
        child: Column(children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      image: AssetImage(url),
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          color: MyColors.FF222222, fontSize: 14),
                    ),
                  ],
                ),
                const Image(
                  image: AssetImage("assets/images/icon_next.png"),
                  width: 7,
                  height: 12.5,
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            decoration: const BoxDecoration(color: MyColors.FFF4F7FD),
          )
        ])),
  );
}
