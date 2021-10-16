import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class MapPage extends StatelessWidget {
  final MapLogic logic = Get.put(MapLogic());
  final MapState state = Get.find<MapLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地图页'),
      ),
      // body:_ShowMapPageBody(),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GetBuilder<MapLogic>(
                builder: (logic) {
                  return AMapWidget(
                      /// 是否显示底层文字
                      labelsEnabled: true,
                      onMapCreated: logic.onMapCreated,
                      // 定位小蓝点配置
                      myLocationStyleOptions: MyLocationStyleOptions(true),
                      // 是否指南针
                      compassEnabled: true,
                      /// 绘制折线
                      // polylines: Set<Polyline>.of(state.polyLines.values));
                      ///绘制点标记
                      markers: Set<Marker>.of(state.markers.values));

                },
              ),
            ),
            Positioned(
                right: 10,
                bottom: 15,
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: logic.approvalNumberWidget),
                )),
            Positioned(
                right: 10,
                bottom: 60,
                child: Container(
                  width: 50 * 3,
                  height: 50,
                  margin: EdgeInsets.only(right: 10, left: 10),
                  child: ElevatedButton(
                    child: Text('开始导航',style: TextStyle(fontSize: 18),),
                    onPressed: (){
                      Get.bottomSheet(
                        Container(
                          color: Colors.white,
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.map),
                                title: Text("高德地图"),
                                onTap: () {
                                  logic.gotoAMap();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.map),
                                title: Text("百度地图"),
                                onTap: () {
                                  logic.gotoBMap();
                                },
                              )
                            ],
                          ),
                        ),
                        isDismissible: true,
                      );
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
