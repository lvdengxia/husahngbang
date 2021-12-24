import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class DeliverPage extends StatelessWidget {
  final DeliverLogic logic = Get.put(DeliverLogic());
  final DeliverState state = Get
      .find<DeliverLogic>()
      .state;
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [Expanded(child: Text('请上传现场照片：' ,style: TextStyle(fontWeight: FontWeight.w600),))],),

                SizedBox(height: padding),

                GetBuilder<DeliverLogic>(
                  builder: (logic) {
                    return Container(
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: padding * 2,
                        children: logic.imageList1(padding),
                      ),
                    );
                  },
                ),

                Row(children: [Expanded(child: Text('请上传成本照片：' ,style: TextStyle(fontWeight: FontWeight.w600),))],),

                SizedBox(height: padding),

                GetBuilder<DeliverLogic>(
                  builder: (logic) {
                    return Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: padding * 2,
                      children: logic.imageList2(padding),
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme
                              .of(context)
                              .primaryColor,
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
