import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hushangbang/components/EmptyData.dart';
import 'package:hushangbang/components/task_card/view.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'logic.dart';
import 'state.dart';

class AllTaskPage extends StatelessWidget {
  final AllTaskLogic logic = Get.put(AllTaskLogic());
  final AllTaskState state = Get.find<AllTaskLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('任务大厅'),
        elevation: 10.0,
        centerTitle: true,
      ),
      body: Container(
          color: Color(0xfff4f5f5), //背景色
          child: EasyRefresh(
            // 是否开启控制结束加载
            enableControlFinishLoad: false,
            controller: state.controller,
            header: ClassicalHeader(
              bgColor: Colors.white,
              infoColor: Theme.of(context).primaryColor,
              textColor: Theme.of(context).primaryColor,
              refreshText: '下拉刷新',
              refreshReadyText: '松开刷新',
              refreshingText: '加载中...',
              refreshedText: '加载完成',
              refreshFailedText: '加载失败',
              showInfo: true,
              infoText: '更新时间: %T',
            ),
            footer: ClassicalFooter(
              bgColor: Colors.white,
              //  更多信息文字颜色
              infoColor: Theme.of(context).primaryColor,
              // 字体颜色
              textColor: Theme.of(context).primaryColor,
              // 加载失败时显示的文字
              loadText: '加载失败',
              // 没有更多时显示的文字
              noMoreText: '没有更多了',
              // 是否显示提示信息
              showInfo: false,
              // 正在加载时的文字
              loadingText: '加载中...',
              // 准备加载时显示的文字
              loadReadyText: '松开加载更多',
              // 加载完成显示的文字
              loadedText: '加载完成',
            ),
            child: Container(
              child: GetBuilder<AllTaskLogic>(
                builder: (logic) {
                  return state.isEmpty
                      ? EmptyData()
                      : Column(
                          children: state.cardData.map((element) {
                            return TaskCard(item: element);
                          }).toList(),
                        );
                },
              ),
            ),
            // 下拉刷新事件回调
            onRefresh: () async {
              await Future.delayed(Duration(seconds: 1), () {
                // 事件处理
                logic.getData();
                // 重置刷新状态 【没错，这里用的是resetLoadState】
                state.controller.resetLoadState();
              });
            },
            // 上拉加载事件回调
            onLoad: () async {
              await Future.delayed(Duration(seconds: 2), () {
                // 加载数据
                logic.onLoadMore();
                // 结束加载
                state.controller.finishLoad();
              });
            },
          )),
    );
  }
}
