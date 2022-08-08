import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:get/get.dart';

class TwoButtonTipDialog extends StatelessWidget {
  String title;
  Function confirmClick;
  TwoButtonTipDialog(this.title, this.confirmClick);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 5,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15))),
            width: 441,
            height: 239,
            child: Column(children: [
              const SizedBox(height: 73),
              Text(title,
                  style:
                      const TextStyle(fontSize: 20, color: MyColors.FF101010)),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(184, 56),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28)), //圆角弧度
                        textStyle: const TextStyle(
                            fontSize: 18, color: Colors.white), //字体
                        elevation: 0,
                        primary: MyColors.FFCBCBCB,
                      ),
                      child: const Text(MyString.cancel)),
                  const SizedBox(width: 40),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              MyColors.FF2966F3,
                              MyColors.FF3AC7FE,
                            ]),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            confirmClick();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(184, 56),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28)), //圆角弧度
                            textStyle: const TextStyle(
                                fontSize: 18, color: Colors.white), //字体
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                          child: const Text(MyString.confirm)))
                ],
              )),
              const SizedBox(height: 25)
            ])));
  }
}
