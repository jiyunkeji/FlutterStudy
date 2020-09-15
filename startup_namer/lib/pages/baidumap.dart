import 'package:flutter/material.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_controller.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_map_options.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/bmfmap_map.dart';

class BaiDuMapView extends StatefulWidget {
  BaiDuMapView({Key key}) : super(key: key);

  _BaiDuMapViewState createState() => _BaiDuMapViewState();
}



class _BaiDuMapViewState extends State<BaiDuMapView> {
  BMFMapController myMapController;

  Size screenSize;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 创建完成回调
  void onBMFMapCreated(BMFMapController controller) {
    myMapController = controller;

    /// 地图加载回调
    myMapController?.setMapDidLoadCallback(callback: () {
      print('mapDidLoad-地图加载完成');
    });
  }

  /// 设置地图参数
  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        center: BMFCoordinate(39.917215, 116.380341),
        zoomLevel: 12,
        mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
    return mapOptions;
  }
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("百度地图"),
      ),
      body: Container(
        height: screenSize.height,
        width: screenSize.width,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: initMapOptions(),
        ),
      )
    );
  }
}
