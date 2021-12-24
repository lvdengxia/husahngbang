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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [Expanded(child: Text('请上传现场照片：' ,style: TextStyle(fontWeight: FontWeight.w600),))],),

            SizedBox(height: padding),

            GetBuilder<LoadedLogic>(
              builder: (logic) {
                return Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceEvenly,
                  spacing: padding * 2,
                  children: logic.imageList(padding),
                );
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
