import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';

import '../exception_handler/data_source.dart';

final class Logger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("= = = Dio Request = = =");
    log("${options.headers}");
    log("${options.data}");
    log("${options.contentType}");
    log("${options.extra}");
    log("${options.baseUrl}${options.path}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("= = = Dio Success Response = = =");
    log(json.encode(response.data));
    log("${response.requestOptions}");
    log("${response.statusCode}");
    log("${response.statusMessage}");
    log("${response.headers}");
    log("${response.extra}");

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log("= = = Dio Error Response = = =");
      log('Error Response: ${err.response}');
      log('Error Message: ${err.message}');
      log('Error Type: ${err.type}');
      log('Error: ${err.error}');
      log('Error Req option: ${err.requestOptions}');
    }
    ErrorHandler.handle(err).failure;
    return super.onError(err, handler);
  }
}
