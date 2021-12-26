import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/models/Upload.dart';
import 'package:image_picker/image_picker.dart';

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
      state.avatar = info['data']['header_img'];
      update();
    }
  }

  selectImageOrigin() async {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("拍 照"),
              onTap: cameraImage,
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("从相册选取"),
              onTap: pickImage,
            )
          ],
        ),
      ),
      isDismissible: true,
    );
  }

  cameraImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      String path = image.path;
      String dirname = path.substring(0, path.lastIndexOf('/'));
      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage(_path);
      });
    }
  }

  pickImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      String path = image.path;
      String? dirname = path.substring(0, path.lastIndexOf('/'));
      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage(_path);
      });
    }
  }

  upLoadImage(image) async {
    Upload res = await ApiService.uploadImage(image);
    if(res.img == ''){
      Get.defaultDialog(title: '上传失败了', middleText: '请稍后再试！');
    }else{
      EasyLoading.showSuccess('上传成功!');
      state.imgUrl.add(res.img);
      update();
    }
  }

  deleteImage(url) {
    state.imgUrl.remove(url);
    ApiService.deleteImage(url);
    update();
  }

  submit() async {
    if(state.imgUrl.length == 0){
      Get.defaultDialog(title: '请选择正确的图片！' ,middleText:'不能为空哦！');
      return;
    }
    var res = await ApiService.upHeaderImg(state.imgUrl[0]);
    if(res['code'] == 200){
      this.getData();
      EasyLoading.showSuccess('修改成功!');
      Get.back();
    }else{
      Get.defaultDialog(title: res['msg'], middleText: '服务器出错！错误码：' + res['code'].toString());
    }
  }
}
