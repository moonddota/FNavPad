import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/res/my_string.dart';
import 'package:get/get.dart';

class SelectQuestionNumberDialog extends StatefulWidget {
  Function(int) confirmClick;
  int maxNum;
  SelectQuestionNumberDialog(this.maxNum, this.confirmClick);

  @override
  State<SelectQuestionNumberDialog> createState() =>
      _SelectQuestionNumberDialogState(maxNum, confirmClick);
}

class _SelectQuestionNumberDialogState
    extends State<SelectQuestionNumberDialog> {
  Function(int) confirmClick;
  int maxNum;
  _SelectQuestionNumberDialogState(this.maxNum, this.confirmClick);
  int num = 10;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 5,
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: 441,
        height: 305,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: MyColors.FF94C0F1,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                height: 63,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      MyString.selectNumberQuestions,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: MyColors.FF101010, fontSize: 25),
                    )
                  ],
                )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    if (num <= 10) {
                      Fluttertoast.showToast(msg: "最少选择10道题");
                      return;
                    }
                    num--;
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Image(
                      image: AssetImage("assets/images/minus_sign.png"),
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                Text(num.toString(),
                    style: const TextStyle(
                        fontSize: 24, color: MyColors.FF101010)),
                InkWell(
                    onTap: () {
                      setState(() {
                        if (num >= maxNum) {
                          Fluttertoast.showToast(msg: "题库最多只有$maxNum道题");
                          return;
                        }
                        num++;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Image(
                        image: AssetImage("assets/images/plus.png"),
                        width: 40,
                        height: 40,
                      ),
                    ))
              ],
            )),
            Row(
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
                          confirmClick(num);
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
            ),
            const SizedBox(height: 25)
          ],
        ),
      ),
    );
  }
}
