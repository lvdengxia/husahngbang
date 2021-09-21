import 'package:amap_flutter_map/amap_flutter_map.dart';

class MapState {

  late String orderSn;

  /// 线点集合
  Map<String, Polyline> polyLines = <String, Polyline>{};

  MapState() {
    ///Initialize variables
    orderSn = '';
  }
}
