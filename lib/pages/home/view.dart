import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());
  final HomeState state = Get.find<HomeLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: state.pageController,
        onPageChanged: logic.switchTap,
        children: state.pageList,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: GetBuilder<HomeLogic>(
        builder: (logic) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '任务大厅'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.fingerprint), label: '待配送订单'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: '个人中心'),
            ],
            currentIndex: state.selectedIndex,
            fixedColor: Colors.deepOrangeAccent,
            onTap: logic.switchTap,
          );
        },
      ),
    );
  }

}