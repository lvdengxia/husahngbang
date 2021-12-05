import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'logic.dart';
import 'state.dart';

class DetailPage extends StatelessWidget {
  final DetailLogic logic = Get.put(DetailLogic());
  final DetailState state = Get
      .find<DetailLogic>()
      .state;
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '配送状态：',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 10,
                ),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(
                      state.distributionStatus,
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('仓库负责人 ：', style: TextStyle(fontSize: padding * 1.5),),
                Container(
                  child: Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          await logic.goCallPage(state.ckdlMobile);
                        },
                        icon: Icon(Icons.phone_forwarded),
                        label: GetBuilder<DetailLogic>(
                          builder: (logic) {
                            return Text(state.ckdlName,
                              style: TextStyle(fontSize: padding * 1.5,
                                  fontWeight: FontWeight.w600),
                            );
                          },
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('司机 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.driveName);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('司机电话 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.driveMobile);
                  },
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('订单号 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.orderSn);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('发货号 ：'),
                Text('2021987765700001'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('姓名 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(
                      state.name,
                      style: TextStyle(
                          fontSize: padding * 2.2, fontWeight: FontWeight.w500),
                    );
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('电话 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.mobile);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('地址 ：'),
                SizedBox(
                  width: 30,
                ),
                Expanded(
                    child: GetBuilder<DetailLogic>(
                      builder: (logic) {
                        return Text(
                          state.address,
                          overflow: TextOverflow.visible,
                        );
                      },
                    )),
              ],
            ),
            Divider(color: Colors.black45,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('是否搬运 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.isTransport);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('楼层 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.storey.toString());
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('搬运类型 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.stairType);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('是否地下车库 ：'),
                GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return Text(state.isUnder);
                  },
                ),
              ],
            ),
            Divider(color: Colors.black45,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: padding * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text(
                        '备注：',
                        style: TextStyle(fontSize: padding * 2),
                      )),
                  Expanded(
                      flex: 8,
                      child: GetBuilder<DetailLogic>(
                        builder: (logic) {
                          return Text(state.note,
                            overflow: TextOverflow.visible,
                            style: TextStyle(fontSize: padding * 2.2),
                          );
                        },
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: padding * 2),
              child: GetBuilder<DetailLogic>(
                  builder: (logic) {
                    return state.isLoading ? Table(
                        border: new TableBorder.all(
                            width: 1.0, color: Colors.black26),
                        children: state.tableRowList
                    ) : Container();
                  }),
            )
          ],
        ),
      ),
    );
  }
}