import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnavpad/main.dart';
import 'package:fnavpad/res/my_colors.dart';
import 'package:fnavpad/ui/my/my.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String page = "home";
  PageController controller = PageController(initialPage: 0, keepPage: true);
  final pageList = [
    HomeList(),
    Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(color: Colors.yellow),
    ),
    MyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bg_home.jpg"),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: PageView(
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: pageList),
                ),
                _getBottom(page, (page) {
                  if (this.page != page) {
                    setState(() {
                      this.page = page;
                      int position;
                      switch (page) {
                        case 'home':
                          position = 0;
                          break;
                        case 'map':
                          position = 1;
                          break;
                        case 'my':
                          position = 2;
                          break;
                        default:
                          position = 0;
                      }
                      controller.jumpToPage(position);
                      // controller.animateToPage(position,
                      //     duration: const Duration(milliseconds: 100),
                      //     curve: Curves.ease);
                    });
                  }
                })
              ],
            )));
  }
}

_getBottom(String page, Function(String) jumpPage) {
  return Container(
    alignment: Alignment.center,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/home_botton_view_bg.png'),
            fit: BoxFit.fill)),
    height: 135,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        _getBottomItem("assets/images/home_to_home.png",
            "assets/images/home_to_home_no.png", page == "home", () {
          jumpPage("home");
        }),
        InkWell(
          onTap: () {
            jumpPage("map");
          },
          child: const Image(
            image: AssetImage('assets/images/home_to_map.png'),
            width: 77,
            height: 77,
          ),
        ),
        _getBottomItem("assets/images/home_to_my.png",
            "assets/images/home_to_my_no.png", page == "my", () {
          jumpPage("my");
        })
      ],
    ),
  );
}

_getBottomItem(String url, String url1, bool selected, Function jumpPage) {
  return Expanded(
      flex: 1,
      child: InkWell(
          onTap: () {
            jumpPage();
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image(
                    image: AssetImage(selected ? url : url1),
                    width: 33,
                    height: 33,
                  )),
              if (selected)
                Container(
                    height: 2,
                    width: 26,
                    decoration:
                        const BoxDecoration(color: MyColors.color_509EF0))
            ],
          )));
}

class HomeItemBean {
  String name;
  String url;
  String path;

  HomeItemBean(this.name, this.url, this.path);
}

class HomeList extends StatelessWidget {
  HomeList({Key? key}) : super(key: key);

  final List<HomeItemBean> list = [
    HomeItemBean("领航准备", "assets/images/home_icon_zhunbei.png", ""),
    HomeItemBean("特情处理", "assets/images/home_icon_special.png", ""),
    HomeItemBean("工具", "assets/images/home_icon_tool.png", ""),
    HomeItemBean("飞行测问", "assets/images/home_icon_questionnaire.png",
        RoutePath.ResultsBank),
    HomeItemBean("资料文档", "assets/images/home_icon_material.png", ""),
    HomeItemBean("数据同步", "assets/images/home_icon_tongbu.png", RoutePath.DataSync),
    HomeItemBean("领航记录表", "assets/images/home_icon_record_form.png", ""),
    HomeItemBean("天气信息", "assets/images/home_icon_weather.png", ""),
    HomeItemBean("模拟训练", "assets/images/home_icon_moni.png", ""),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(top: 60, left: 42),
            child: Text(
              "你好！",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
        const Padding(
            padding: EdgeInsets.only(left: 42),
            child: Text('欢迎使用电子领航图囊',
                style: TextStyle(color: Colors.white, fontSize: 10))),
        Container(
          margin: const EdgeInsets.only(top: 25, left: 42, right: 42),
          width: double.infinity,
          height: 600,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/home_rv_bg.png"),
                  fit: BoxFit.fill)),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final item = list[index];
                return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: InkWell(
                        onTap: () {
                          if (item.path.isNotEmpty) Get.toNamed(item.path);
                        },
                        child: Column(
                          children: [
                            Image(
                              image: AssetImage(item.url),
                              width: 122,
                              height: 122,
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              flex: 1,
                              child: Text(item.name,
                                  style: const TextStyle(
                                      color: MyColors.FF555555, fontSize: 14)),
                            ),
                          ],
                        )));
              }),
        )
      ],
    );
  }
}
