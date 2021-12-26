import 'package:dio/dio.dart';
import 'package:hushangbang/global/Global.dart';
import 'dart:convert' show json;

import 'package:hushangbang/models/Upload.dart';

class ApiService {
  /// baseUrl
  static const String BASE_URL = 'http://tp.lookjb.com/index';

  static Future sendLoginData(String mobile, String pwd) async {
    Response response = await Global.getInstance()
        .dio
        .post('/Login/login', data: {'name': mobile, 'pwd': pwd});

    return json.decode(response.data.toString());
    // return Login.fromJson(json.decode(response.data.toString()));
  }

  static Future sendPwdData(
      String pwd, String rePwd, String mobile, String code) async {
    Response response = await Global.getInstance().dio.post('/Login/forget',
        data: {'mobile': mobile, 'pwd': pwd, 'pwd_s': rePwd, 'code': code});
    return json.decode(response.data.toString());
  }

  static Future getVerifyCode(String mobile) async {
    Response response = await Global.getInstance()
        .dio
        .post('/Login/getCode', data: {'mobile': mobile});

    return json.decode(response.data.toString());
  }

  /// 获取司机基本信息
  static Future getDriverBaseInfo() async {
    Response response = await Global.getInstance().dio.get('/User/getUserInfo');

    return json.decode(response.data.toString());
  }

  /// 订单列表
  static Future getOrderList({int type = 0, int page = 1}) async {
    Response response = await Global.getInstance()
        .dio
        .post('/Order/getOrderList', data: {'type': type, 'page': page});

    return json.decode(response.data.toString());
  }

  /// 订单详情
  static Future getOrderDetail({String orderSn = ''}) async {
    Response response = await Global.getInstance()
        .dio
        .post('/order/orderDetail', data: {'order_sn': orderSn});

    return json.decode(response.data.toString());
  }

  /// 拒绝接单
  static Future refuseOrder(String orderSn) async {
    Response response = await Global.getInstance()
        .dio
        .post('/Order/refuseOrder', data: {'order_sn': orderSn});

    return json.decode(response.data.toString());
  }

  /// 接单
  static Future receiveOrder(String orderSn, int type, {String? img}) async {
    Map data = img != null
        ? {'order_sn': orderSn, 'type': type, 'distribution_img': img}
        : {'order_sn': orderSn, 'type': type};

    Response response =
        await Global.getInstance().dio.post('/Order/receiveOder', data: data);

    return json.decode(response.data.toString());
  }

  /// 获取上传定位周期
  static Future getPushLocationTime() async {
    Response response =
        await Global.getInstance().dio.get('/Order/getLocationTime');

    return json.decode(response.data.toString());
  }

  /// 发送司机定位
  static Future postDriverLocation(longitude,latitude) async {
    Response response = await Global.getInstance().dio.post(
        '/Order/saveAtPresentLocation',
        data: {'longitude': longitude, 'latitude': latitude});

    return json.decode(response.data.toString());
  }

  /// 根据订单号获取轨迹
  static Future getTrackByOrderSn(orderSn) async {
    Response response = await Global.getInstance()
        .dio
        .post('/Order/getOrderTrack', data: {'order_sn': orderSn});

    return json.decode(response.data.toString());
  }

  /// 路径规划
  static Future getPathByOrderSn(orderSn,location) async {
    Response response = await Global.getInstance().dio.get(
        '/Order/getOrderRoute',
        queryParameters: {'order_sn': orderSn, 'location': location});

    return json.decode(response.data.toString());
  }


  /// 文件上传
  static Future uploadImage(file) async {
    FormData formData = FormData.fromMap(
        {'fileUpload': await MultipartFile.fromFile(file)});
    Response response =
        await Global.getInstance().dio.post('/Index/uplode', data: formData);

    return Upload.fromJson(response.data);
  }

  /// 文件删除
  static Future deleteImage(url) async {
    Response response = await Global.getInstance().dio
        .get('/Index/delupload', queryParameters: {'img': url});
    return json.decode(response.data.toString());
  }

  /// 上传现场照片列表
  static Future upOrderImgType(
      String orderSn, int type, List<String> img) async {
    Map data = {'order_sn': orderSn, 'type': type, 'img': img};

    Response response = await Global.getInstance()
        .dio
        .post('/Order/upOrderImgType', data: data);

    return json.decode(response.data.toString());
  }

  /// 上传现场照片列表
  static Future upHeaderImg(String img) async {
    Map data = {'img': img};

    Response response = await Global.getInstance()
        .dio
        .post('/User/upHeaderImg', data: data);

    return json.decode(response.data.toString());
  }
}
