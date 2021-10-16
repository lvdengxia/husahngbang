import 'package:flutter_easyrefresh/easy_refresh.dart';

class TodoState {

  late EasyRefreshController todayController;

  // late EasyRefreshController allController;

  List todayCardData = [];
  List allDayCardData = [];

  int todayPage = 1;
  int allDayPage = 1;

  int todaySize = 0;
  int allDaySize = 0;

  bool todayEmpty = true;
  bool allDayEmpty = true;

  bool todayNoMore = false;
  bool allDayNoMore = false;

  TodoState() {
    ///Initialize variables

    todayController = new EasyRefreshController();

    // allController = new EasyRefreshController();
  }
}
