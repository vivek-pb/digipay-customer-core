import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'config.dart';
import 'custom_log_interceptor.dart';

typedef OnError = void Function(String error, Map<String, dynamic> data);
typedef OnResponse<Response> = void Function(Response response);

enum ApiEnvironment { UAT, Dev, Prod }

extension APIEnvi on ApiEnvironment {
  String get endpoint {
    switch (this) {
      case ApiEnvironment.UAT:
        return 'http://192.168.1.102:8014/';
      case ApiEnvironment.Dev: //local-192
        return 'http://192.168.1.102:8014/';
      case ApiEnvironment.Prod:
        return '';
      default:
        return "";
    }
  }
}

class DioFactory {
  static APILog apiLog = APILog.cURL;

  static final _singleton = DioFactory._instance();

  static Dio? get dio => _singleton._dio;
  static var _authorization = '';

  static void initialiseHeaders(String token) {
    if (token == "") {
      _authorization = "";
    } else {
      _authorization = 'Bearer $token';
    }

    dio!.options.headers[HttpHeaders.authorizationHeader] = _authorization;
  }

  Dio? _dio;

  ///TODO : Base URL
  DioFactory._instance() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEnvironment.Dev.endpoint,
        headers: {
          HttpHeaders.authorizationHeader: _authorization,
        },
        connectTimeout: Config.timeout,
        receiveTimeout: Config.timeout,
        sendTimeout: Config.timeout,
      ),
    );
    if (!kReleaseMode) {
      _dio!.interceptors.add(
        CustomLogInterceptor(
          request: Config.logNetworkRequest,
          requestHeader: Config.logNetworkRequestHeader,
          requestBody: Config.logNetworkRequestBody,
          responseHeader: Config.logNetworkResponseHeader,
          responseBody: Config.logNetworkResponseBody,
          error: Config.logNetworkError,
          cURLRequest: APILog.cURL == apiLog,
        ),
      );
    }
  }
}
