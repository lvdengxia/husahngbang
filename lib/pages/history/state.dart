import 'package:flutter_easyrefresh/easy_refresh.dart';

class HistoryState {

  late EasyRefreshController historyController;

  List historyCardData = [];

  int historyPage = 1;

  int historySize = 0;

  bool historyEmpty = true;

  bool historyNoMore = false;

  HistoryState() {
    ///Initialize variables

    historyController = new EasyRefreshController();
  }
}
