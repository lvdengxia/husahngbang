import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
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

    if (data['code'] == 200) {
      if (!data['data']['list'].isEmpty) {
        List arr = [];
        for (var i = 0; i < data['data']['list'].length; i++) {
          if( data['data']['list'][i]['status'] == 202 && data['data']['list'][i]['distribution_status'] == 1){
             arr.add(data['data']['list'][i]);
          }
        }
        state.cardData = arr;
        state.size = state.cardData.length;
        if(state.size > 0)  state.isEmpty = false;
        update();
      }
    }
  }

  onLoadMore() async {
    var data = await ApiService.getOrderList(page: state.page + 1);

    if (data['code'] == 200 && !data['data']['list'].isEmpty) {
      for (var i = 0; i < data['data']['list'].length; i++) {
        if( data['data']['list'][i]['status'] == 201 && data['data']['list'][i]['distribution_status'] == 1){
          state.cardData.add(data['data']['list'][i]);
        }
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
