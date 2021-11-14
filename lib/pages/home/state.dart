import 'package:flutter/material.dart';
import 'package:hushangbang/pages/all_task/view.dart';
import 'package:hushangbang/pages/person/view.dart';
import 'package:hushangbang/pages/todo/view.dart';
import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';

class HomeState {

  late int selectedIndex;

  late PageController pageController;

  ///PageView页面
  late List<Widget> pageList;

  /// 上传周期
  late int pushTime;

  /// 定位扩展
  AMapFlutterLocation locationPlugin = new AMapFlutterLocation();

  /// 返回结果 (经纬度信息)
  late Map<String, Object> locationResult;

  AMapLocationOption locationOption = new AMapLocationOption();

  HomeState() {
    ///Initialize variables
    selectedIndex = 0;

    ///PageView页面
    pageList = [
      AllTaskPage(),
      TodoPage(),
      PersonPage()
    ];

    /// 底部菜单选项卡的控制器
    pageController = PageController();

    /// 本地先写成15s
    pushTime = 5;

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

  }
}
