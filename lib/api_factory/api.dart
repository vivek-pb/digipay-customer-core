import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import '../log/pb_log.dart';
import 'dio_factory.dart';

enum HttpMethod { delete, get, patch, post, put }

class Api {
  static const tag = "Api";

  static Future<void> request({
    HttpMethod method = HttpMethod.get,
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      dio.Response response;
      switch (method) {
        case HttpMethod.post:
          response = await DioFactory.dio!.post(
            path,
            options: Options(
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
              },
            ),
            data: params,
          );
          break;
        case HttpMethod.delete:
          response = await DioFactory.dio!.delete(
            path,
            data: params,
          );
          break;
        case HttpMethod.get:
          response = await DioFactory.dio!.get(
            path,
            queryParameters: params,
          );
          break;
        case HttpMethod.patch:
          response = await DioFactory.dio!.patch(
            path,
            data: params,
          );
          break;
        case HttpMethod.put:
          response = await DioFactory.dio!.put(
            path,
            options: Options(headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
            data: params,
          );
          break;
        default:
          return;
      }

      if (response.statusCode == 401) {
        PBLog('Success Error', tag: tag);
      } else {
        return response.data['data'];
      }
    } catch (e) {
      String errorMessage = "";
      if (e is DioException) {
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.sendTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.unknown) {
          errorMessage = 'Server unreachable';
        } else if (e.type == DioExceptionType.badResponse) {
          errorMessage = e.response!.data['detail'];
        } else {
          errorMessage = "Request cancelled";
        }
      } else {
        errorMessage = "Something went wrong! Please try again.";
      }
      PBLog('errorMessage : $e', tag: tag);
    }
  }
}

mixin class APIResponse {
  onResponse(String apiKey, dynamic response) {}

  onError(String apiKey, String error) {}
}
