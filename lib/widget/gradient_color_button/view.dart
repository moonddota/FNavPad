import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/my_colors.dart';
import 'logic.dart';

class GradientColorButtonWidget extends StatefulWidget {
  String text;
  Function block;
  late double width;
  late double height;
  late bool buttonEnablel;

  GradientColorButtonWidget(this.text, this.block,
      {this.width = 348, this.height = 56, this.buttonEnablel = false});

  @override
  _GradientColorButtonWidgetState createState() =>
      _GradientColorButtonWidgetState();
}

class _GradientColorButtonWidgetState extends State<GradientColorButtonWidget> {
  final logic = Get.put(GradientColorButtonLogic());
  final state = Get.find<GradientColorButtonLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: widget.buttonEnablel
                  ? [
                      MyColors.FF2966F3,
                      MyColors.FF3AC7FE,
                    ]
                  : [MyColors.FF94C0F1, MyColors.FF94C0F1]),
        ),
        child: ElevatedButton(
            onPressed: () {
              if (widget.buttonEnablel) widget.block();
            },
            style: ElevatedButton.styleFrom(
                // minimumSize: Size(0.8.sw, 56.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                //圆角弧度
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                //字体
                elevation: 0,
                primary: Colors.transparent),
            child: Text(widget.text)));
  }

  @override
  void dispose() {
    Get.delete<GradientColorButtonLogic>();
    super.dispose();
  }
}
