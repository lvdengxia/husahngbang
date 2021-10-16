import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';

import 'state.dart';

class PersonLogic extends GetxController {
  final state = PersonState();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData();
  }


  getData() async {
    var info = await ApiService.getDriverBaseInfo();
    if(info['code'] == 200){
      state.name = info['data']['name'];
      state.mobile = info['data']['mobile'];
      state.plateNumber = info['data']['plate_number'];
      state.plateGroup = info['data']['plate_group'];
      state.load = info['data']['load'];
      state.credentialsFront = info['data']['credentials_front'];
      state.credentialsContrary = info['data']['credentials_contrary'];
      state.remarks = info['data']['remarks'];
      state.status = info['data']['status'];

      update();
    }
  }
}
