import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/models/Upload.dart';
import 'package:hushangbang/pages/todo/logic.dart';
import 'package:image_picker/image_picker.dart';

import 'state.dart';

class DeliverLogic extends GetxController {
  final state = DeliverState();

  @override
  void onInit() {
    /// implement onInit
    super.onInit();
    ///获取参数
    state.orderSn = Get.arguments;
  }


  pickImage1() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    upLoadImage1(image);
  }

  upLoadImage1(image) async {
    Upload res = await ApiService.uploadImage(image);
    if(res.img == ''){
      Get.defaultDialog(title: '上传失败了',middleText:'请稍后再试！');
    }else{
      state.imgUrl1 = res.img;
      update();
    }
  }

  pickImage2() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    upLoadImage2(image);
  }

  upLoadImage2(image) async {
    Upload res = await ApiService.uploadImage(image);
    if(res.img == ''){
      Get.defaultDialog(title: '上传失败了',middleText:'请稍后再试！');
    }else{
      state.imgUrl2 = res.img;
      update();
    }
  }

  submit() async {

    var res1 = await ApiService.receiveOrder(state.orderSn,4,img: state.imgUrl1);
    var res2 = await ApiService.receiveOrder(state.orderSn,4,img: state.imgUrl2);
    TodoLogic logic = Get.put(TodoLogic());
    await logic.refreshToDayData();

    if(res1['code'] == 200 && res2['code'] == 200){
      Get.back();
    }else{
      Get.defaultDialog(title: res1['msg'], middleText: '服务器出错！错误码：' + res1['code'].toString());
    }


  }

}
