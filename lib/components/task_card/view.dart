import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'logic.dart';
import 'state.dart';

class TaskCard extends StatelessWidget {
  final TaskCardLogic logic = Get.put(TaskCardLogic());
  final TaskCardState state = Get.find<TaskCardLogic>().state;
  final width = window.physicalSize.width;
  final item;
  final isShowMapWidget;

  TaskCard({this.item, this.isShowMapWidget = true});

  @override
  Widget build(BuildContext context) {
    double padding = width / 100;
    return Container(
      padding: EdgeInsets.only(top: padding, left: padding, right: padding),
      child: GestureDetector(
        onTap: () => logic.goOrderDetailPage(item['order_sn']),
        child: Card(
          elevation: 2,
          shadowColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(padding * 1.5)),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['send_time'].toString(),
                      style: TextStyle(
                          fontSize: padding * 2.2,
                          fontWeight: FontWeight.w600,
                          wordSpacing: 1.3),
                    ),
                    IconButton(
                        onPressed: () {
                          logic.goCallPage(item['mobile']);
                        },
                        icon: Icon(Icons.phone_forwarded))
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          item['order_status'] ?? '????????? ' + ' ?????????',
                          style: TextStyle(color: Colors.red),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // Text(
                        //   '????????????',
                        //   style: TextStyle(color: Colors.grey),
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('????????? ???'),
                        Text(item['order_sn']),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('????????? ???'),
                    //     Text('2021987765700001'),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('?????? ???'),
                        Text(
                          item['name'],
                          style: TextStyle(
                              fontSize: padding * 2.0, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('?????? ???'),
                        Text(item['mobile']),
                      ],
                    ),
                    isShowMapWidget ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('?????? ???',style: TextStyle(
                            fontSize: padding * 2.0, fontWeight: FontWeight.w500),),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.place_outlined,
                          color: Colors.red,
                        ),
                        Expanded(
                            child: GestureDetector(
                              onTap: (){
                                logic.goMapPage(item['order_sn'],
                                item['location'][0], item['location'][1]);
                          },
                              child: Text(
                          item['province']+item['city']+item['district']+item['address'],
                          overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: padding * 2.0, fontWeight: FontWeight.w500),
                        ),
                            )),
                        Icon(Icons.keyboard_arrow_right,color: Colors.red,)
                      ],
                    ) : Container(),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: padding*2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex:3,
                        child: Text(
                      '??????\n?????????',
                      style: TextStyle(fontSize: padding * 2.1),
                    )),
                    Expanded(
                        flex: 8,
                        child: Text(
                          item['province'] + item['city'] + item['district'] + item['address'],
                          overflow: TextOverflow.visible,
                          style: TextStyle(fontSize: padding * 2.2),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // children: [
                  //   item['btn'][0]['show'] == 0 ? Container() : ElevatedButton(
                  //       onPressed: () => logic.onRefuse('orderSn'),
                  //       child: Text('????????????')),
                  //   item['btn'][1]['show'] == 0 ? Container() : ElevatedButton(
                  //       onPressed: () => logic.onReceive('orderSn'),
                  //       child: Text('????????????')),
                  //   item['btn'][2]['show'] == 0 ? Container() : ElevatedButton(
                  //       onPressed: () => {},
                  //       child: Text('????????????')),
                  //   item['btn'][3]['show'] == 0 ? Container() : ElevatedButton(
                  //       onPressed: () => {},
                  //       child: Text('????????????')),
                  //   item['btn'][4]['show'] == 0 ? Container() : ElevatedButton(
                  //       onPressed: () => {},
                  //       child: Text('????????????')),
                  // ],
                  children: logic.button(item),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
