import 'package:dio/dio.dart';

const DB_URL = 'https://jsonbox.io/box_12aaafc84bca41c916a0';

Dio crateDio() {
  BaseOptions options =
      BaseOptions(baseUrl: DB_URL, connectTimeout: 5000, receiveTimeout: 3000);

  Dio dio = Dio(options);

  dio.interceptors.add(LogInterceptor(
      error: true,
      request: false,
      responseBody: true,
      responseHeader: false,
      requestHeader: false));

  return dio;
}
