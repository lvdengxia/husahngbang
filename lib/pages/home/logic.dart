import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'state.dart';

class HomeLogic extends GetxController {
  final state = HomeState();

  StreamSubscription<Map<String, Object>>? locationListener;

  @override
  void onInit()  async {
    // TODO: implement onInit
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getString('token') == null ){
      Get.offNamed('/login');
    }else{
      /// 获取上传定位周期
      var res  = await ApiService.getPushLocationTime();
      if(res['code'] == 200){
        state.pushTime = res['data']['s'];
        update();
      }

      /// 动态申请定位权限
      requestPermission();

      ///注册定位结果监听
      locationListener = state.locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
        state.locationResult = result;
        update();
      });

      /// 开始任务
      this.startLocation();


      /// 定时任务
      Timer.periodic(Duration(seconds: state.pushTime), (timer)  {
        this.sendLocation();
      });
    }
  }

  ///切换tab   如果想跳转页面可以在这里使用 Get.push
  void switchTap(int index) {
    state.selectedIndex = index;
    state.pageController.jumpToPage(index);
    update();
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await this.requestLocationPermission();
    bool hasPhonePermission = await this.requestPhonePermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
      Get.defaultDialog(title: '定位权限申请不通过',middleText:'无法获取定位，任何人将无法看到您的位置！');
    }

    if (hasPhonePermission) {
      print("拨打电话权限申请通过");
    } else {
      print("拨打电话权限申请不通过");
      Get.defaultDialog(title: '拨打电话权限申请不通过',middleText:'点击拨打电话图标将无效，您无法快捷拨打收货人电话！');
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

  /// 申请拨打电话权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestPhonePermission() async {
    //获取当前的权限
    var status = await Permission.phone.status;
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

  ///开始定位
  void startLocation() {
    ///开始定位之前设置定位参数
    _setLocationOption();
    state.locationPlugin.startLocation();
  }

  ///停止定位
  void stopLocation() {
    state.locationPlugin.stopLocation();
  }

  ///设置定位参数
  void _setLocationOption() {
    ///将定位参数设置给定位插件
    state.locationPlugin.setLocationOption(state.locationOption);
  }

  /// 发送定位给服务端记录
  void sendLocation() async {
     await ApiService.postDriverLocation(
        state.locationResult!['longitude'], state.locationResult!['latitude']);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    locationListener?.cancel();
  }
}
