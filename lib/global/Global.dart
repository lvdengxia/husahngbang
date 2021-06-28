import 'package:dio/dio.dart';

class Global {

  static  Global ? _instance;
  late Dio  dio;

  static Global getInstance(){
    if (_instance == null )   _instance = new Global();
    return _instance ?? new Global();
  }

  Global(){
    dio = new Dio();
    dio.options = BaseOptions(
      baseUrl: "http://tangran.test/api",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {
          "token": "XXX",
      }
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) {
        return handler.resolve(Response(requestOptions:error.requestOptions,data:error.response?.statusCode.toString()));

      },
    ));
  }
}
