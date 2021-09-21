import 'package:dio/dio.dart';
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
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        return handler.resolve(Response(
            requestOptions: error.requestOptions,
            data: error.response?.statusCode.toString()));
      },
    ));
  }
}
