import 'package:flutter/material.dart';

class DetailState {

  late bool isLoading;
  late List<TableRow> tableRowList;

  /// 订单号
  late String orderSn;

  /// 用户姓名
  late String name;

  /// 用户手机号
  late String mobile;

  /// 用户地址
  late String address;

  /// 是否搬运
  late String isTransport;

  /// 是否地下车库
  late String isUnder;

  /// 楼层
  late int storey;

  /// 搬运类型
  late String stairType;

  /// 备注留言
  late String note;


  /// 配送状态
  late String  distributionStatus;

  /// 司机姓名
  late String  driveName;

  /// 司机手机号
  late String  driveMobile;

  DetailState() {
    ///Initialize variables
    isLoading = true;
    tableRowList = [];
    orderSn = '';
    name = '';
    mobile = '';
    address = '';
    isTransport = '';
    isUnder = '';
    storey = 0;
    stairType = '';
    note = '';

    distributionStatus = '';
    driveName = '';
    driveMobile = '';
  }
}
