import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:hushangbang/components/PhotoViewSimpleScree.dart';
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

  selectImageOrigin1() async {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("拍 照"),
              onTap: cameraImage1,
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("从相册选取"),
              onTap: pickImage1,
            )
          ],
        ),
      ),
      isDismissible: true,
    );
  }

  cameraImage1() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image != null){
      String? path = image.path;
      String? dirname = path.substring(0, path.lastIndexOf('/'));
      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage1(_path);
      });
    }
  }

  pickImage1() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      String? path = image.path;
      String? dirname = path.substring(0, path.lastIndexOf('/'));
      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage1(_path);
      });
    }
  }

  upLoadImage1(image) async {
    Upload res = await ApiService.uploadImage(image);
    if (res.img == '') {
      Get.defaultDialog(title: '上传失败了', middleText: '请稍后再试！');
    } else {
      EasyLoading.showSuccess('上传成功!');
      state.imgUrl1.add(res.img);
      update();
    }
  }

  deleteImage1(url) async{
    state.imgUrl1.remove(url);
    await ApiService.deleteImage(url);
    update();
  }

  List<Widget> imageList1(padding) {
    List<Widget> list = [];
    for (var i = 0; i < state.imgUrl1.length; i++) {
      String remoteUrl  = state.imgUrl1[i];
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
                deleteImage1(remoteUrl);
              },
            ),
          )
        ],
      ));
    }

    if (state.imgUrl1.length < state.maxSize) {
      list.add(GestureDetector(
        onTap: selectImageOrigin1,
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



  selectImageOrigin2() async {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("拍 照"),
              onTap: cameraImage2,
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("从相册选取"),
              onTap: pickImage2,
            )
          ],
        ),
      ),
      isDismissible: true,
    );
  }

  cameraImage2() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    if(image!=null){
      String? path = image.path;
      String? dirname = path.substring(0, path.lastIndexOf('/'));

      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage2(_path);
      });
    }
  }

  pickImage2() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      String? path = image.path;
      String? dirname = path.substring(0, path.lastIndexOf('/'));
      CompressObject compressObject = CompressObject(
        imageFile: File(path.toString()),
        path: dirname,
      );
      Get.back();
      EasyLoading.showProgress(0.3,status: '压缩中...');
      Luban.compressImage(compressObject).then((_path) {
        EasyLoading.showProgress(0.3,status: '正在上传...');
        upLoadImage2(_path);
      });
    }
  }

  upLoadImage2(image) async {
    Upload res = await ApiService.uploadImage(image);
    if (res.img == '') {
      Get.defaultDialog(title: '上传失败了', middleText: '请稍后再试！');
    } else {
      EasyLoading.showSuccess('上传成功!');
      state.imgUrl2.add(res.img);
      update();
    }
  }

  deleteImage2(url) async {
    state.imgUrl2.remove(url);
    await ApiService.deleteImage(url);
    update();
  }

  List<Widget> imageList2(padding) {
    List<Widget> list = [];
    for (var i = 0; i < state.imgUrl2.length; i++) {
      String remoteUrl = state.imgUrl2[i];
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
              )
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              child: Icon(Icons.delete),
              onTap: (){
                deleteImage2(remoteUrl);
              },
            ),
          )
        ],
      ));
    }

    if (state.imgUrl2.length < state.maxSize) {
      list.add(GestureDetector(
        onTap: selectImageOrigin2,
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

  submit() async {
    if(state.imgUrl1.length == 0 || state.imgUrl2.length == 0 ){
      Get.defaultDialog(title: '请选择正确的图片！' ,middleText:'不能为空哦！');
      return;
    }

    var res1 = await ApiService.upOrderImgType(state.orderSn, 2, state.imgUrl1);
    var res2 = await ApiService.upOrderImgType(state.orderSn, 3, state.imgUrl2);

    TodoLogic logic = Get.put(TodoLogic());
    await logic.refreshToDayData();

    if (res1['code'].toString() == '200' && res2['code'].toString() == '200') {
      /// 跳转历史订单
      Get.offAllNamed("/history");
    } else {
      Get.defaultDialog(
          title: res1['msg'],
          middleText: '服务器出错！错误码：' + res1['code'].toString());
    }
  }
}
