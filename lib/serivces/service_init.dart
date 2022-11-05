import 'package:dio/dio.dart';

Dio apiCall([String? token]) {
  var _dio = Dio();
  _dio
    ..options.baseUrl = 'https://d-order.takhruj.com/'
    ..options.connectTimeout = 60 * 2000;

  if (token != null) {
    _dio.options.headers['authorization'] = 'Bearer $token';
  }

  return _dio;
}
