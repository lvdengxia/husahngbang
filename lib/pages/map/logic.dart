import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hushangbang/api/api.dart';
import 'package:permission_handler/permission_handler.dart';
import 'state.dart';
import 'dart:async';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class MapLogic extends GetxController {
  final state = MapState();

  @override
  void onInit() async {
    super.onInit();

    ///获取参数
    state.orderSn = Get.arguments['orderSn'];
    state.latitude = Get.arguments['latitude'];
    state.longitude = Get.arguments['longitude'];

    requestPermission();

    /// 获取轨迹 && 画线
    // await this.getDriverAndDraw();
    draw();

    update();
  }

  draw(){
    LatLng end =  LatLng(double.parse(state.latitude),double.parse(state.longitude));
    Marker marker = Marker(position: end);
    state.markers[marker.id] = marker;
  }

  getDriverAndDraw() async {
    var res = await ApiService.getTrackByOrderSn(state.orderSn);
    if(res['code'] == 200){
      this.add(res['data']['res']);
    }
  }

  AMapController? _mapController;

  List<Widget> approvalNumberWidget = [];

  void onMapCreated(AMapController controller) {
    _mapController = controller;
    this.getApprovalNumber();
  }

  /// 获取审图号
  void getApprovalNumber() async {
    //普通地图审图号
    String? mapContentApprovalNumber =
    await _mapController?.getMapContentApprovalNumber();
    //卫星地图审图号
    String? satelliteImageApprovalNumber =
    await _mapController?.getSatelliteImageApprovalNumber();

    if (null != mapContentApprovalNumber) {
      approvalNumberWidget.add(Text(mapContentApprovalNumber));
    }
    if (null != satelliteImageApprovalNumber) {
      approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
    }

    // print('地图审图号（普通地图）: $mapContentApprovalNumber');
    // print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }


  /// 创建点
  List<LatLng> createPoints(List res) {
    final List<LatLng> points = <LatLng>[];
    final int polylineCount = state.polyLines.length;
    final double offset = polylineCount * -(0.01);
    if(res.length > 0){
      res.forEach((element) {
        points.add(LatLng(element['latitude'] + offset, element['longitude']));
      });
    }
    points.add(LatLng(39.938698, 116.275177));
    points.add(LatLng(39.966069 + offset, 116.289253));
    points.add(LatLng(39.944226 + offset, 116.306076));
    points.add(LatLng(39.966069 + offset, 116.322899));
    points.add(LatLng(39.938698 + offset, 116.336975));

    return points;
  }

  /// 渲染点
  void add(List res) {
    Polyline polyline = Polyline(
        color: Colors.green,
        width: 10,
        points: this.createPoints(res),
        onTap: this.onPolylineTapped
    );
    state.polyLines[polyline.id] = polyline;
    update();
  }

  /// 点击线的回调
  onPolylineTapped(String polylineId) {
    print('Polyline: $polylineId 被点击了');
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await this.requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
      Get.defaultDialog(title: '定位权限申请不通过',middleText:'无法获取定位，任何人将无法看到您的位置！');
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.locationAlways.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }


  /// 高德地图导航
  Future<bool> gotoAMap() async{
    var url = 'androidamap://navi?sourceApplication=amap&lat=${state.longitude}&lon=${state.latitude}&dev=0&style=2';

    var res = await gotoMap(url: url);
    if(!res){
      Get.defaultDialog(title: '未安装高德地图',middleText:'无法跳转到高德地图！');
      return false;
    }
    return true;
  }

  /// 百度地图导航
  Future<bool> gotoBMap() async {
    var bmapLocation = amapLocation2Bmap(state.latitude,state.longitude);
    var url ='baidumap://map/direction?destination=${bmapLocation[0]},${bmapLocation[1]}&coord_type=gcj02&mode=driving';

    var res = await gotoMap(url: url);
    if(!res){
      Get.defaultDialog(title: '未安装百度地图',middleText:'无法跳转到百度地图！');
      return false;
    }
    return true;
  }


  Future<bool> gotoMap({String url = ''}) async {
    bool canLaunchUrl = await isMapInstall(url);

    if (!canLaunchUrl)  return false;

    await launch(url);

    return true;
  }

  /// 判断地图是否有安装
  static Future<bool> isMapInstall(String url) {
    return canLaunch(url);
  }

  ///GPS坐标转百度地图坐标（传入经度、纬度）
  amapLocation2Bmap(latitude,longitude){
      var X_PI = pi * 3000.0 / 180.0;
      var x = double.parse(longitude);
      var y = double.parse(latitude);
      var z = sqrt(x * x + y * y) + 0.00002 * sin(y * X_PI);
      var theta = atan2(y, x) + 0.000003 * cos(x * X_PI);
      var bdLng = z * cos(theta) + 0.0065;
      var bdLat = z * sin(theta) + 0.006;
      return [bdLng,bdLat];
  }


  // function gps_bgps(gg_lng, gg_lat) {
  //   var X_PI = Math.PI * 3000.0 / 180.0;
  //   var x = gg_lng, y = gg_lat;
  //   var z = Math.sqrt(x * x + y * y) + 0.00002 * Math.sin(y * X_PI);
  //   var theta = Math.atan2(y, x) + 0.000003 * Math.cos(x * X_PI);
  //   var bd_lng = z * Math.cos(theta) + 0.0065;
  //   var bd_lat = z * Math.sin(theta) + 0.006;
  //   return {
  //     bd_lat: bd_lat,
  //     bd_lng: bd_lng
  //   };
  // }

// @override
// void onInit() {
//   // TODO: implement onInit
//   /// 动态申请定位权限
//   requestPermission();
//
//   ///注册定位结果监听
//   _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
//     locationResult = result;
//     update();
//   });
//
//   super.onInit();
// }
//
// ///开始定位
// void startLocation() {
//   ///开始定位之前设置定位参数
//   _setLocationOption();
//   _locationPlugin.startLocation();
// }
//
// ///停止定位
// void stopLocation() {
//   _locationPlugin.stopLocation();
// }
//
// ///设置定位参数
// void _setLocationOption() {
//   AMapLocationOption locationOption = new AMapLocationOption();
//
//   ///是否单次定位
//   locationOption.onceLocation = false;
//
//   ///是否需要返回逆地理信息
//   locationOption.needAddress = true;
//
//   ///逆地理信息的语言类型
//   locationOption.geoLanguage = GeoLanguage.DEFAULT;
//
//   locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;
//
//   locationOption.fullAccuracyPurposeKey = "AMapLocationScene";
//
//   ///设置Android端连续定位的定位间隔
//   locationOption.locationInterval = 2000;
//
//   ///设置Android端的定位模式<br>
//   ///可选值：<br>
//   ///<li>[AMapLocationMode.Battery_Saving]</li>
//   ///<li>[AMapLocationMode.Device_Sensors]</li>
//   ///<li>[AMapLocationMode.Hight_Accuracy]</li>
//   locationOption.locationMode = AMapLocationMode.Hight_Accuracy;
//
//   ///设置iOS端的定位最小更新距离<br>
//   locationOption.distanceFilter = -1;
//
//   ///设置iOS端期望的定位精度
//   /// 可选值：<br>
//   /// <li>[DesiredAccuracy.Best] 最高精度</li>
//   /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
//   /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
//   /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
//   /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
//   locationOption.desiredAccuracy = DesiredAccuracy.Best;
//
//   ///设置iOS端是否允许系统暂停定位
//   locationOption.pausesLocationUpdatesAutomatically = false;
//
//   ///将定位参数设置给定位插件
//   _locationPlugin.setLocationOption(locationOption);
// }
//
//
//
//
//
//
// /// 动态申请定位权限
// void requestPermission() async {
//   // 申请权限
//   bool hasLocationPermission = await requestLocationPermission();
//   if (hasLocationPermission) {
//     print("定位权限申请通过");
//   } else {
//     print("定位权限申请不通过");
//   }
// }
//
// /// 申请定位权限
// /// 授予定位权限返回true， 否则返回false
// Future<bool> requestLocationPermission() async {
//   //获取当前的权限
//   var status = await Permission.location.status;
//   if (status == PermissionStatus.granted) {
//     //已经授权
//     return true;
//   } else {
//     //未授权则发起一次申请
//     status = await Permission.location.request();
//     if (status == PermissionStatus.granted) {
//       return true;
//     } else {
//       return false;
//     }
//   }
// }
//
// @override
// void dispose() {
//   super.dispose();
//
//   ///移除定位监听
//   if (null != _locationListener) {
//     _locationListener?.cancel();
//   }
//
//   ///销毁定位
//   _locationPlugin.destroy();
// }
}
