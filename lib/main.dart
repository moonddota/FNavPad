import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fnavpad/bean/FlyResults.dart';
import 'package:fnavpad/bean/user.dart';
import 'package:fnavpad/plateform_adapter/window/window_size_helper.dart';
import 'package:fnavpad/ui/home/home.dart';
import 'package:fnavpad/ui/data_sync/view.dart';
import 'package:fnavpad/ui/login/login.dart';
import 'package:fnavpad/ui/questron/answer/resultsAnswer.dart';
import 'package:fnavpad/ui/questron/bank/resultsBank.dart';
import 'package:fnavpad/ui/questron/detail/resultsDetails.dart';
import 'package:fnavpad/ui/questron/record/record.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get/get.dart';

void main() async {
  await InitHive();
  runApp(const MyApp());
  await GetStorage.init();
  WindowSizeHelper.setFixSize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'fNavPad',
        initialRoute: RoutePath.Login, // 默认加载的界面
        getPages: RoutePath.getPages,
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init());
  }
}

class RoutePath {
  /// page name
  static const String Login = "/login";
  static const String Home = "/home";
  static const String DataSync = "/DataSync";
  static const String ResultsBank = "/quertron_bank";
  static const String ResultsAnswer = "/quertron_answer";
  static const String ResultsDetail = "/quertron_detail";
  static const String ResultsRecord = "/quertron_record";

  ///pages map
  static final List<GetPage> getPages = [
    GetPage(name: Login, page: () => LoginPage()),
    GetPage(name: Home, page: () => HomePage()),
    GetPage(name: DataSync, page: () => DataSyncPage()),
    GetPage(name: ResultsBank, page: () => ResultsBankPage()),
    GetPage(name: ResultsAnswer, page: () => ResultsAnswerPage()),
    GetPage(name: ResultsDetail, page: () => ResultsDetailsPage()),
    GetPage(name: ResultsRecord, page: () => ResultsRecordPage()),
  ];
}

Future<void> InitHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FlyResultsAdapter());
}
