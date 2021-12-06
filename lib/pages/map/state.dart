import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';

class MapState {

  late String orderSn;

  late String longitude;

  late String latitude;

  late LatLng centerPointer;

  late List<LatLng> pointList;
  /// 线点集合
  Map<String, Polyline> polyLines = <String, Polyline>{};

  /// 点集合
  Map<String, Marker> markers = <String, Marker>{};

  MapState() {
    ///Initialize variables
    orderSn = '';
    longitude = '116.397451';
    latitude = '39.909187';

    ///默认显示在北京天安门
    centerPointer = LatLng(39.909187, 116.397451);
    pointList = [];
  }
}
