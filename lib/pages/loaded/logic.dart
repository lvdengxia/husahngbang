import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/components/PhotoViewSimpleScree.dart';
import 'package:hushangbang/models/Upload.dart';
import 'package:hushangbang/pages/todo/logic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


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

  List<Widget> imageList(padding) {
    List<Widget> list = [];
    for (var i = 0; i < state.imgUrl.length; i++) {
      String remoteUrl  = state.imgUrl[i];
      list.add(Stack(
        children: [
          Container(
            width: padding * 10,
            height: padding * 10,
            padding: EdgeInsets.all(padding),
            margin: EdgeInsets.only(bottom: padding),
            decoration: BoxDecoration(
                color: Color(0xfff4f5f5),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.black26),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 1.0,
                      spreadRadius: 1.0),
                ]),
            child: GestureDetector(
              child: Image.network(
                remoteUrl,
                fit: BoxFit.fill,
              ),
              onTap: (){
                Get.to(PhotoViewSimpleScreen(
                    imageProvider: NetworkImage(remoteUrl,scale: 0.9), heroTag: 'simple')
                );
              },
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              child: Icon(Icons.delete),
              onTap: (){
                deleteImage(remoteUrl);
              },
            ),
          )
        ],
      ));
    }

    if (state.imgUrl.length < state.maxSize) {
      list.add(GestureDetector(
        onTap: selectImageOrigin,
        child: Container(
          width: padding * 10,
          height: padding * 10,
          margin: EdgeInsets.only(bottom: padding),
          decoration: BoxDecoration(
              color: Color(0xfff4f5f5),
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Colors.black26),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0,
                    spreadRadius: 1.0),
              ]),
          child: Align(
            alignment: Alignment.center,
            child: Icon(Icons.photo_camera),
          ),
        ),
      ));
    }

    return list;
  }

  deleteImage(url) async {
    state.imgUrl.remove(url);
    await ApiService.deleteImage(url);
    update();
  }

  submit() async {
    if(state.imgUrl.length == 0){
      Get.defaultDialog(title: '请选择正确的图片！' ,middleText:'不能为空哦！');
      return;
    }

    var res = await ApiService.upOrderImgType(state.orderSn, 1, state.imgUrl);
    if(res['code'] == 200){

      TodoLogic logic = Get.put(TodoLogic());
      await logic.refreshToDayData();

      EasyLoading.showSuccess('ok!');
      Get.back();
    }else{
      Get.defaultDialog(title: res['msg'], middleText: '服务器出错！错误码：' + res['code'].toString());
    }
  }
}
