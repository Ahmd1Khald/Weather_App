import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://api.weatherapi.com/v1/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required url,
    required Map<String, dynamic> query,
    required String key,
  }) async {
    dio.options.headers = {
      'key': key,
    };

    return await dio.get(url, queryParameters: query);
  }
}
