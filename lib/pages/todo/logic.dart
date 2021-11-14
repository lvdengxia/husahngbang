import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'state.dart';
import 'dart:convert' show json;


class TodoLogic extends GetxController {
  final state = TodoState();

  @override
  void onInit() async {
    super.onInit();
    this.refreshToDayData();
    // this.refreshAllDayData();
  }

  refreshToDayData() async {
    var data = await ApiService.getOrderList(type: 1);

    if (data['code'] == 200) {
      if (!data['data']['list'].isEmpty) {
        List arr = [];
        for (var i = 0; i < data['data']['list'].length; i++) {
          if (data['data']['list'][i]['status'] == 202 &&
                  data['data']['list'][i]['distribution_status'] == 2 ||
              data['data']['list'][i]['status'] == 202 &&
                  data['data']['list'][i]['distribution_status'] == 3 ||
              data['data']['list'][i]['status'] == 202 &&
                  data['data']['list'][i]['distribution_status'] == 4) {
            arr.add(data['data']['list'][i]);
          }
        }
        state.todayCardData = arr;
        state.todaySize = state.todayCardData.length;

        if(state.todaySize > 0)  state.todayEmpty = false;
        update();
      }
    }
  }

  refreshAllDayData() async {
    var data = await ApiService.getOrderList();

    // /// 模拟数据
    // var data;
    // await rootBundle.loadString('asset/OrderList.json').then((value) {
    //   data = json.decode(value.toString());
    // });

    if (data['code'] == 200) {
      if (!data['data']['list'].isEmpty) {
        state.allDayEmpty = false;
        List arr = [];
        for (var i = 0; i < data['data']['list'].length; i++) {
          arr.add(data['data']['list'][i]);
        }
        state.allDayCardData = arr;
        state.allDaySize = state.allDayCardData.length;
        update();
      }
    }
  }

  loadToDayData() async {
    var data = await ApiService.getOrderList(type:1,page: state.todayPage + 1);

    if (data['code'] == 200 && !data['data']['list'].isEmpty) {
      for (var i = 0; i < data['data']['list'].length; i++) {
        if (data['data']['list'][i]['status'] == 202 &&
            data['data']['list'][i]['distribution_status'] == 2) {
          state.todayCardData.add(data['data']['list'][i]);
        }
      }
      state.todaySize = state.todayCardData.length;
      state.todayPage += 1;
      update();
    }
  }

  loadAllDayData() async {
    var data = await ApiService.getOrderList(page: state.allDayPage + 1);

    if (data['code'] == 200 && !data['data']['list'].isEmpty) {
      for (var i = 0; i < data['data']['list'].length; i++) {
        state.allDayCardData.add(data['data']['list'][i]);
      }
      state.allDaySize = state.allDayCardData.length;
      state.allDayPage += 1;
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // state.allController.dispose();
    state.todayController.dispose();
  }
}

