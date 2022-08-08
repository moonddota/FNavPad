import 'package:flutter/material.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:get/get.dart';

class TopBar extends StatelessWidget {
  String title;
  String menuName;
  Function? menuClick;

  TopBar(this.title, {this.menuName = "", this.menuClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        MyColors.FF2966F3,
        MyColors.FF3AC7FE,
      ])),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Image(
                      image: AssetImage("assets/images/icon_back.png"),
                      width: 12,
                      height: 21,
                    ),
                  ))),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                  onTap: () {
                    if (menuClick != null) menuClick!();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Text(
                      menuName,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ))),
        ],
      ),
    );
  }
}
