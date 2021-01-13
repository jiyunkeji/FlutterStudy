// Flutter code sample for FlexibleSpaceBar

// This sample application demonstrates the different features of the
// [FlexibleSpaceBar] when used in a [SliverAppBar]. This app bar is configured
// to stretch into the overscroll space, and uses the
// [FlexibleSpaceBar.stretchModes] to apply `fadeTitle`, `blurBackground` and
// `zoomBackground`. The app bar also makes use of [CollapseMode.parallax] by
// default.

import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/bdmap_location_flutter_plugin.dart';
import 'package:startup_namer/pages/baidumap.dart';
import 'package:startup_namer/pages/calendar.dart';
import 'package:startup_namer/pages/mainview.dart';
import 'package:startup_namer/pages/tabnav.dart';
import 'dart:io' show Platform;
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
    show BMFMapSDK, BMF_COORD_TYPE;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    //jyjZG075WkdL5Gl5hugaDshGg5msQEuw
    BMFMapSDK.setApiKeyAndCoordType(
        'rGdFTyZ5HdN1fU8gPeyaRvq20QRMeHBw', BMF_COORD_TYPE.BD09LL);
    LocationFlutterPlugin.setApiKey("rGdFTyZ5HdN1fU8gPeyaRvq20QRMeHBw");
  } else if (Platform.isAndroid) {
// Android 目前不支持接口设置Apikey,
// 请在主工程的Manifest文件里设置，详细配置方法请参考[https://lbsyun.baidu.com/ 官网][https://lbsyun.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
  }
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MainView(),
        '/calendar': (BuildContext context) => Calender(),
        '/baiDuMapView': (BuildContext context) => BaiDuMapView(),
        '/tabView': (BuildContext context) => TabNavWidget(),
      },
    );
  }
}
