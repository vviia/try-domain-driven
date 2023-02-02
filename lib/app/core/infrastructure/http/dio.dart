import 'package:dio/dio.dart';
import 'package:trying_to_not_crying/app/core/infrastructure/http/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ConfiguredDio {
  late final Dio dio;
  final String? token;

  ConfiguredDio(this.token) {
    dio = Dio(BaseOptions(baseUrl: HttpConstants.apiPath, headers: {
/*
      'Content-Type': 'application/json',
      'connection': 'keep-alive',
*/
      ...getTokenHeader(token)
    }));

    dio.interceptors.add(PrettyDioLogger());
  }

  Map<String, String> getTokenHeader(String? token) => token == null
      ? {}
      : {
    'Authorization': 'Bearer $token',
  };

  void updateToken(String token) {
    dio.options.headers = getTokenHeader(token);
  }
}