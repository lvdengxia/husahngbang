import 'package:amap_flutter_map/amap_flutter_map.dart';

class MapState {

  late String orderSn;

  late String longitude;

  late String latitude;

  /// 线点集合
  Map<String, Polyline> polyLines = <String, Polyline>{};

  /// 点集合
  Map<String, Marker> markers = <String, Marker>{};

  MapState() {
    ///Initialize variables
    orderSn = '';
    longitude = '116.397451';
    latitude = '39.909187';
  }
}
