import 'package:get/get.dart';
import 'package:hushangbang/pages/detail/view.dart';
import 'package:hushangbang/pages/find_pwd/view.dart';
import 'package:hushangbang/pages/history/view.dart';
import 'package:hushangbang/pages/home/view.dart';
import 'package:hushangbang/pages/loaded/view.dart';
import 'package:hushangbang/pages/login/view.dart';
import 'package:hushangbang/pages/map/view.dart';


List<GetPage> routes = [
    GetPage(name: '/', page: () => HomePage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/find_pwd', page: () => FindPwdPage()),
    GetPage(name: '/map', page: () => MapPage()),
    GetPage(name: '/detail', page: () => DetailPage()),
    GetPage(name: '/loaded', page: () => LoadedPage()),
    GetPage(name: '/history', page: () => HistoryPage()),
];