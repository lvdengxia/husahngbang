import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';

import 'state.dart';

class HistoryLogic extends GetxController {
  final state = HistoryState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    refreshHistoryData();
  }

  refreshHistoryData() async {
    var data = await ApiService.getOrderList();
    if (data['code'] == 200) {
      if (!data['data']['list'].isEmpty) {
        List arr = [];
        for (var i = 0; i < data['data']['list'].length; i++) {
          if (data['data']['list'][i]['status'] == 202 &&
                  data['data']['list'][i]['distribution_status'] == 4 ||
              data['data']['list'][i]['status'] > 202) {
            arr.add(data['data']['list'][i]);
          }
        }
        state.historyCardData = arr;
        state.historySize = state.historyCardData.length;
        if(state.historySize > 0)  state.historyEmpty = false;
        update();
      }
    }
  }


  loadHistoryData() async {
    var data = await ApiService.getOrderList(page: state.historyPage + 1);

    if (data['code'] == 200 && !data['data']['list'].isEmpty) {
      for (var i = 0; i < data['data']['list'].length; i++) {

        if (data['data']['list'][i]['status'] == 202 &&
            data['data']['list'][i]['distribution_status'] == 4 ||
            data['data']['list'][i]['status'] > 202) {
          state.historyCardData.add(data['data']['list'][i]);
        }
      }
      state.historySize = state.historyCardData.length;
      state.historyPage += 1;
      update();
    }
  }

  @override
  void dispose() {
    super.dispose();
    state.historyController.dispose();
  }
}
