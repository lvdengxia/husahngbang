import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/pages/all_task/logic.dart';
import 'package:hushangbang/pages/todo/logic.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

class TaskCardLogic extends GetxController {
  final state = TaskCardState();

  List<Widget> button(item) {
    List lists = item['btn'];
    List<Widget> buttons = [];
    if (lists[0]['show'] != 0) {
      buttons.add(ElevatedButton(
          onPressed: () => onRefuse(item['order_sn']), child: Text('取消接单')));
    }
    if (lists[1]['show'] != 0) {
      buttons.add(ElevatedButton(
          onPressed: () => onReceive(item['order_sn']), child: Text('确认接单')));
    }
    if (lists[2]['show'] != 0) {
      buttons.add(ElevatedButton(
          onPressed: () => onFeedback(item['order_sn']), child: Text('订单反馈')));
    }
    if (lists[3]['show'] != 0) {
      buttons.add(ElevatedButton(
          onPressed: () => onLoaded(item['order_sn']), child: Text('装货完成')));
    }
    if (lists[4]['show'] != 0) {
      buttons.add(ElevatedButton(
          onPressed: () => onFinished(item['order_sn']), child: Text('确认送达')));
    }

    return buttons;
  }

  /// 拒绝接单
  onRefuse(orderSn) async {
    var res = await ApiService.refuseOrder(orderSn);

    AllTaskLogic logic = Get.put(AllTaskLogic());
    await logic.getData();

    Get.defaultDialog(title: '提示', middleText: res['msg']);
  }

  ///接单  2 确认接单
  onReceive(orderSn) async {
    var res = await ApiService.receiveOrder(orderSn, 2);

    AllTaskLogic logic = Get.put(AllTaskLogic());
    await logic.getData();

    Get.defaultDialog(title: '提示', middleText: res['msg']);
  }

  /// 订单反馈
  onFeedback(orderSn) async {
    Get.defaultDialog(title: '反馈成功', middleText: '请主动联系公司客服或物流人员!');
  }

  /// 装货完成
  onLoaded(orderSn) {
    Get.toNamed('/loaded', arguments: orderSn.toString());
  }

  /// 确认送达
  onFinished(orderSn) async {

    Get.toNamed('/deliver', arguments: orderSn.toString());

    // var res = await ApiService.receiveOrder(orderSn, 4);
    //
    // TodoLogic logic = Get.put(TodoLogic());
    // await logic.refreshToDayData();
    //
    // Get.defaultDialog(title: '提示', middleText: res['msg']);
  }

  /// 跳转地图页
  goMapPage(orderSn, latitude, longitude) {
    Get.toNamed('/map', arguments: {
      'orderSn': orderSn.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString()
    });
  }

  /// 点击跳转拨打电话页
  goCallPage(mobile) {
    launch("tel://" + mobile);
  }

  /// 跳转订单详情页
  goOrderDetailPage(orderSn) {
    Get.toNamed('/detail', arguments: orderSn.toString());
  }
}
