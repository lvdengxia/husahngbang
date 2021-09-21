import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hushangbang/routes/route.dart';
import 'package:get/get.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
//      debugShowCheckedModeBanner: false,
      title: '沪上帮',
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent,
      ),
      getPages: routes,
    );
  }
}

// void main() => runApp(App());

void main(){
  runApp(App());
  if(Platform.isAndroid){
    /// 设置状态栏背景色
    SystemUiOverlayStyle  systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}