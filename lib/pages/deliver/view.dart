import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class DeliverPage extends StatelessWidget {
  final DeliverLogic logic = Get.put(DeliverLogic());
  final DeliverState state = Get.find<DeliverLogic>().state;
  final width = window.physicalSize.width;

  @override
  Widget build(BuildContext context) {
    double padding = width / 100;
    return
      Scaffold(
          appBar: AppBar(
            title: Text('确认送达'),
            elevation: 10.0,
            centerTitle: true,
          ),
          body: Container(
            color: Color(0xfff4f5f5), //背景色
            padding: EdgeInsets.all(padding * 2),
            child: Column(
              children: [
                Text('确认送达页面'),
                SizedBox(height: padding),

                GetBuilder<DeliverLogic>(
                  builder: (logic) {
                    return state.imgUrl1 == ''
                        ? GestureDetector(
                      onTap: logic.pickImage1,
                      child: Container(
                        margin: EdgeInsets.only(bottom: padding),
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
                        height: padding * 20,
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
                        margin: EdgeInsets.only(bottom: padding),
                        width: double.infinity,
                        height: padding * 20,
                        child: Image(
                            image: NetworkImage(state.imgUrl1),
                            fit: BoxFit.cover
                        ));
                  },
                ),

                GetBuilder<DeliverLogic>(
                  builder: (logic) {
                    return state.imgUrl2 == ''
                        ? GestureDetector(
                      onTap: logic.pickImage2,
                      child: Container(
                        margin: EdgeInsets.only(top: padding),
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
                        height: padding * 20,
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
                        margin: EdgeInsets.only(top: padding),
                        width: double.infinity,
                        height: padding * 20,
                        child: Image(
                            image: NetworkImage(state.imgUrl2),
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
          )
    );
  }
}
