import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';

import 'state.dart';

class DetailLogic extends GetxController {
  final state = DetailState();

  @override
  void onInit()  async {
    // TODO: implement onInit
    super.onInit();
    var res = await getOrderDetail(Get.arguments);
    if(res['code'] == 200) {
      /// 组装商品数据
      if(res['data']['storey_amount_details'].length != 0){
        print('1');
        state.tableRowList = tableRow(res['data']['storey_amount_details']);
      }

      state.orderSn = res['data']['order_sn'] ?? '';
      state.name = res['data']['order_buyer']['name'] ?? '';
      state.mobile = res['data']['order_buyer']['mobile'] ?? '';
      state.address = res['data']['order_buyer']['province'] ?? '' + res['data']['order_buyer']['city'] ?? ''+
              res['data']['order_buyer']['district'] ?? ''+ res['data']['order_buyer']['address'] ?? '';

      state.isTransport = res['data']['is_transport'] == 1 ? '是' : '否';
      state.isUnder = res['data']['is_under'] == 1 ? '是' : '否';
      state.storey = res['data']['storey'] ?? '';
      state.stairType = res['data']['stair_type'] ?? '';
      state.note = res['data']['note'] ?? '';

      switch (res['data']['order_freight']['distribution_status']) {
        case 1:
          state.distributionStatus = '待接单';
          break;
        case 2:
          state.distributionStatus = '已接单';
          break;
        case 3:
          state.distributionStatus = '配货完成';
          break;
        case 4:
          state.distributionStatus = '已送达';
          break;
        default:
          state.distributionStatus = '错误状态';
      }

      state.driveName = res['data']['order_freight']['drive_name'] ?? '';
      state.driveMobile = res['data']['order_freight']['drive_mobile'] ?? '';

      update();
    }
  }

  /// 组装商品
  List<TableRow> tableRow(details) {
    List<TableRow> list = [];
    list.add(new TableRow(
      children: <Widget>[
        new TableCell(
          child: new Center(
            child: new Text(
              '送货商品',
              style: TextStyle(fontSize: 16),
            ),
          ),
        )
      ],
    ));
    list.add(new TableRow(
      children: <Widget>[
        new TableCell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(' 名称（属性）'),
              Text(' 数量 '),
            ],
          ),
        )
      ],
    ));

    details.forEach((item){
      list.add(new TableRow(
        children: <Widget>[
          new TableCell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 6,
                    child: Text(
                      ' ' + item['goods_name'],
                    )),
                Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        ' ' + item['goods_number'].toString(),
                      ),
                    )),
              ],
            ),
          )
        ],
      ));
    });

    return list;
  }

  /// 请求数据
  getOrderDetail(orderSn) async {
    return await ApiService.getOrderDetail(orderSn: orderSn);
  }


  /// 获取表格列表
  getTableRowList(){
    return state.tableRowList;
  }
}