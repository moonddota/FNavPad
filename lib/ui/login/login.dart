import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnavpad/bean/user.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';

import '../../res/SPConfig.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool buttonEnable = false;
  bool userHasFocus = false;
  bool passwordHasFocus = false;
  String userName = "";
  String password = "";

  late Box userBox;

  @override
  void initState() {
    super.initState();
    initBox();
  }

  initBox() async {
    userBox = await Hive.openBox<User>(DBName.user);
    var list = userBox.values;
    var e = list.where((e) => e.userName == "admin" && e.password == "admin");
    if (e.isEmpty) {
      userBox.add(User()
        ..id = "-1000"
        ..name = "admin"
        ..password = "admin"
        ..userName = "admin"
        ..userType = 0);
    }
  }

  @override
  void dispose() {
    super.dispose();
    userBox.close();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/login_background.png"),
              fit: BoxFit.fill)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(height: 166),
          const Text(
            MyString.app_name,
            style: TextStyle(
              fontSize: 36,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
          const SizedBox(height: 50),
          Container(
            width: 428,
            height: 433,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Column(
              children: [
                const SizedBox(height: 41),
                const Text(MyString.welcomeLogin,
                    style: TextStyle(fontSize: 21, color: MyColors.FF101010)),
                const SizedBox(height: 42),
                LoginInput("assets/images/login_user.png", "admin",
                    MyString.enterAccount, false, (value) {
                  setState(() {
                    userName = value;
                    buttonEnable = userName.isNotEmpty && password.isNotEmpty;
                  });
                }),
                const SizedBox(height: 21),
                LoginInput("assets/images/login_password.png", "admin",
                    MyString.enterPassword, true, (value) {
                  setState(() {
                    password = value;
                    buttonEnable = userName.isNotEmpty && password.isNotEmpty;
                  });
                }),
                const SizedBox(height: 55),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: buttonEnable
                              ? [
                                  MyColors.FF2966F3,
                                  MyColors.FF3AC7FE,
                                ]
                              : [MyColors.FF94C0F1, MyColors.FF94C0F1]),
                    ),
                    child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(348, 56),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28)),
                          //圆角弧度
                          textStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          //字体
                          elevation: 0,
                          primary: Colors.transparent,
                        ),
                        child: const Text(MyString.login)))
              ],
            ),
          ),
          const SizedBox(height: 140),
          const Image(
            image: AssetImage("assets/images/company_name.png"),
            width: 300,
            height: 50,
          )
        ]),
      ),
    );
  }

  _login() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!buttonEnable) {
      return;
    } else {
      var list = userBox.values;
      var e = list
          .where((e) => e.userName == userName && e.password == password)
          .toList();
      if (e.isEmpty) {
        Fluttertoast.showToast(msg: "账号或密码错误");
        return;
      } else {
        final _box = GetStorage();
        _box.write(SPConfig.user, jsonEncode(e[0]));
        Get.offAndToNamed(RoutePath.Home);
      }
    }
  }
}

class LoginInput extends StatefulWidget {
  String hintText;
  String initString;
  String url;
  bool isPassword;
  Function(String) textChange;

  LoginInput(this.url, this.initString, this.hintText, this.isPassword,
      this.textChange);

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final focusNode = FocusNode();
  bool hasFocus = false;
  bool obscureText = true;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      widget.textChange(controller.text);
    });
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
    Timer(const Duration(seconds: 1), () {
      controller.text = widget.initString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      width: 349,
      height: 56,
      decoration: const BoxDecoration(
          color: MyColors.FFF1F5F9,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(children: [
        const SizedBox(width: 24),
        Image(image: AssetImage(widget.url), width: 23, height: 24),
        const SizedBox(width: 11),
        Expanded(
            flex: 1,
            child: TextField(
              obscureText: obscureText,
              focusNode: focusNode,
              controller: controller,
              maxLength: 8,
              style: const TextStyle(fontSize: 12, color: Colors.black),
              decoration: InputDecoration(
                counterText: '',
                hintText: widget.hintText,
                hintStyle:
                    const TextStyle(fontSize: 12, color: MyColors.FFB9B9B9),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            )),
        if (hasFocus)
          InkWell(
              onTap: () {
                controller.text = "";
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Image(
                    image: AssetImage("assets/images/icon_et_clear.png"),
                    width: 23,
                    height: 24),
              )),
        if (widget.isPassword)
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(
                        image: AssetImage(obscureText
                            ? "assets/images/password_show.png"
                            : "assets/images/password_hide.png"),
                        width: 23,
                        height: 24)),
              ),
              const SizedBox(width: 10)
            ],
          )
      ]),
    ));
  }
}
