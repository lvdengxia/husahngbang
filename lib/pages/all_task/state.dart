import 'package:flutter_easyrefresh/easy_refresh.dart';

class AllTaskState {
  late EasyRefreshController controller;
  List cardData = [];
  int page = 1;
  int size = 0;
  bool isEmpty = true;
  bool noMore = false;
  AllTaskState() {
    ///Initialize variables
    controller = new EasyRefreshController();
  }
}
