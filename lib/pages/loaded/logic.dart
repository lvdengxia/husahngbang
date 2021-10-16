import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/models/Upload.dart';
import 'package:hushangbang/pages/todo/logic.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class LoadedLogic extends GetxController {
  final state = LoadedState();

  @override
  void onInit() {
    /// implement onInit
    super.onInit();
    ///获取参数
    state.orderSn = Get.arguments;
  }


  pickImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    upLoadImage(image);
  }

  upLoadImage(image) async {
    Upload res = await ApiService.uploadImage(image);
    if(res.img == ''){
      Get.defaultDialog(title: '上传失败了',middleText:'请稍后再试！');
    }else{
      state.imgUrl = res.img;
      update();
    }
  }

  submit() async {
    var res = await ApiService.receiveOrder(state.orderSn,3,img: state.imgUrl);

    TodoLogic logic = Get.put(TodoLogic());
    await logic.refreshToDayData();

    if(res['code'] == 200){
      Get.back();
    }else{
      Get.defaultDialog(title: res['msg'], middleText: '服务器出错！错误码：' + res['code'].toString());
    }
  }
}
