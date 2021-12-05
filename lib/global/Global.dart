import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hushangbang/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static Global? _instance;
  late Dio dio;

  static Global getInstance() {
    if (_instance == null) _instance = new Global();
    return _instance ?? new Global();
  }

  Global() {
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: ApiService.BASE_URL,
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {}
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');
        if (token != null &&
            options.path.indexOf('/Login/forget') == -1 &&
            options.path.indexOf('/Login/getCode') == -1 &&
            options.path.indexOf('/Login/login') == -1)
          options.headers['token'] = token;

        // print("\n================================= 请求数据 =================================");
        // print("method = ${options.method.toString()}");
        // print("url = ${options.uri.toString()}");
        // print("headers = ${options.headers}");
        // print("params = ${options.queryParameters}");

        return handler.next(options);
      },
      onResponse: (response, handler)  async {
        if(response.statusCode == 401){
          Get.defaultDialog(title: '提示', middleText: '账号异常，请重新登录！');

          /// 直接退出吧，自动登录不好使。
          SharedPreferences prefs =
          await SharedPreferences.getInstance();
          prefs.remove('token'); //删除指定键
          prefs.clear(); //清空键值对
          Get.offAllNamed('/login');

          /// 服务端有bug 自动登录
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // String account = prefs.getString('account') ?? '';
          // String pwd = prefs.getString('pwd') ?? '';
          // var login = await ApiService.sendLoginData(account,pwd);
          // if(login['code'].toString() == '200'){
          //   prefs.remove('token'); //删除再更新 避免缓存
          //   prefs.setString('token',login['data']['token']);
          // }else{
          //   Get.defaultDialog(title: '提示', middleText: '账号异常，请重新登录！');
          // }
        }
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        // return handler.resolve(Response(
        //     requestOptions: error.requestOptions,
        //     data: error.response?.statusCode.toString()));
      },
    ));
  }
}
