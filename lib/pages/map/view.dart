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
                      labelsEnabled: false,
                      onMapCreated: logic.onMapCreated,
                      // 定位小蓝点配置
                      // myLocationStyleOptions: MyLocationStyleOptions(true),
                      // 是否指南针
                      compassEnabled: true,
                      /// 绘制折线
                      polylines: Set<Polyline>.of(state.polyLines.values));
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
                ))
          ],
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('地图页'),
//     ),
//     body: Column(
//       children: [
//         new Container(
//             alignment: Alignment.center,
//             child: new Row(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 new ElevatedButton(
//                   onPressed: () => logic.startLocation(),
//                   child: new Text('开始定位'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.blue),
//                     foregroundColor: MaterialStateProperty.all(Colors.white),
//                   ),
//                 ),
//                 new Container(width: 20.0),
//                 new ElevatedButton(
//                   onPressed: () => logic.stopLocation(),
//                   child: new Text('停止定位'),
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.blue),
//                     foregroundColor: MaterialStateProperty.all(Colors.white),
//                   ),
//                 )
//               ],
//             )),
//         GetBuilder<MapLogic>(builder: (logic) {
//           List<Widget> widgets = <Widget>[];
//           logic.locationResult?.forEach((key, value) {
//             widgets.add(_resultWidget(key, value));
//           });
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: widgets,
//           );
//         }),
//       ],
//     ),
//   );
// }

// Widget _resultWidget(key, value) {
//   return new Container(
//     child: new Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         new Container(
//           alignment: Alignment.centerRight,
//           width: 100.0,
//           child: new Text('$key :'),
//         ),
//         new Container(width: 5.0),
//         new Flexible(child: new Text('$value', softWrap: true)),
//       ],
//     ),
//   );
// }
}

//
// class _ShowMapPageBody extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _ShowMapPageState();
// }
//
// class _ShowMapPageState extends State<_ShowMapPageBody> {
//   List<Widget> _approvalNumberWidget = [];
//
//   @override
//   Widget build(BuildContext context) {
//     final AMapWidget map = AMapWidget(
//       /// 是否显示底层文字
//       // labelsEnabled:false,
//       onMapCreated: onMapCreated,
//       // 定位小蓝点配置
//       myLocationStyleOptions: MyLocationStyleOptions(true),
//       // 是否指南针
//       // compassEnabled: true,
//       /// 绘制折线
//       // polylines:Set<Polyline>.of(polylines.values)
//
//     );
//
//     return ConstrainedBox(
//       constraints: BoxConstraints.expand(),
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: map,
//           ),
//           Positioned(
//               right: 10,
//               bottom: 15,
//               child: Container(
//                 alignment: Alignment.centerLeft,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: _approvalNumberWidget),
//               ))
//         ],
//       ),
//     );
//   }
//
//   AMapController? _mapController;
//
//   void onMapCreated(AMapController controller) {
//     setState(() {
//       _mapController = controller;
//       getApprovalNumber();
//     });
//   }
//
//   /// 获取审图号
//   void getApprovalNumber() async {
//     //普通地图审图号
//     String? mapContentApprovalNumber =
//     await _mapController?.getMapContentApprovalNumber();
//     //卫星地图审图号
//     String? satelliteImageApprovalNumber =
//     await _mapController?.getSatelliteImageApprovalNumber();
//     setState(() {
//       if (null != mapContentApprovalNumber) {
//         _approvalNumberWidget.add(Text(mapContentApprovalNumber));
//       }
//       if (null != satelliteImageApprovalNumber) {
//         _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
//       }
//     });
//     print('地图审图号（普通地图）: $mapContentApprovalNumber');
//     print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
//   }
//
// }
