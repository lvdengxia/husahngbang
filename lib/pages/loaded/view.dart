import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class LoadedPage extends StatelessWidget {
  final LoadedLogic logic = Get.put(LoadedLogic());
  final LoadedState state = Get.find<LoadedLogic>().state;
  final width = window.physicalSize.width;

  @override
  Widget build(BuildContext context) {
    double padding = width / 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xfff4f5f5), //背景色
        padding: EdgeInsets.all(padding * 2),
        child: Column(
          children: [
            Row(
              children: [Expanded(child: Text('请按照示例图上传照片'))],
            ),
            SizedBox(height: padding),
            GetBuilder<LoadedLogic>(
              builder: (logic) {
                return state.imgUrl == ''
                    ? GestureDetector(
                        onTap: logic.pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xfff4f5f5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.black26),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 1.0,
                                    spreadRadius: 1.0),
                              ]),
                          width: double.infinity,
                          height: padding * 40,
                          child: Container(
                            padding: EdgeInsets.only(top: padding * 17),
                            child: Column(
                              children: [
                                Icon(Icons.photo_camera),
                                Text('点击上传图片')
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: padding * 40,
                        child: Image(
                          image: NetworkImage(state.imgUrl),
                          fit: BoxFit.cover
                        ));
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(height: 55.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle:
                          TextStyle(color: Colors.white, fontSize: 20.0)),
                  onPressed: logic.submit,
                  child: Text('提 交'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
