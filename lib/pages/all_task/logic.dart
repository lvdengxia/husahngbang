import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:flutter/material.dart';
import 'dart:convert' show json;

import 'state.dart';

class AllTaskLogic extends GetxController {
  final state = AllTaskState();

  @override
  void onInit() async {
    super.onInit();
    this.getData();
  }

  getData() async {
    var data = await ApiService.getOrderList();

    // /// 模拟数据
    // var data;
    // await rootBundle.loadString('asset/OrderList.json').then((value) {
    //   data = json.decode(value.toString());
    // });

    if (data['code'] == 200) {
      if (!data['data']['list'].isEmpty) {
        state.isEmpty = false;
        List arr = [];
        for (var i = 0; i < data['data']['list'].length; i++) {
          arr.add(data['data']['list'][i]);
        }
        state.cardData = arr;
        state.size = state.cardData.length;
        update();
      }
    }
  }

  onLoadMore() async {
    var data = await ApiService.getOrderList(page: state.page + 1);

    /// 模拟数据
    // var data;
    // await rootBundle.loadString('asset/OrderList.json').then((value) {
    //   data = json.decode(value.toString());
    // });

    if (data['code'] == 200 && !data['data']['list'].isEmpty) {
      for (var i = 0; i < data['data']['list'].length; i++) {
        state.cardData.add(data['data']['list'][i]);
      }
      state.size = state.cardData.length;
      state.page += 1;
      update();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    state.controller.dispose();
  }
}
