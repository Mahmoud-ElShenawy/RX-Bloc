import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rx_bloc/common/keys.dart';
import 'package:rx_bloc/service/interceptors/dio_connectivity_request_retrier.dart';
import 'package:rx_bloc/service/interceptors/retry_interceptor.dart';
import 'package:rx_bloc/util/util_shared.dart';

const _defaultConnectTimeout = Duration.millisecondsPerMinute;
const _defaultReceiveTimeout = Duration.millisecondsPerMinute;

class ApiProvider {
  static final ApiProvider _instance = ApiProvider.internal();

  ApiProvider.internal();

  factory ApiProvider() => _instance;

  final Dio _dio = Dio();

  String lang = 'en';
  String token = '';

  static const Map<String, String> apiHeaders = {
    'Content-Type': 'application/json',
    "Accept": "application/json, text/plain, */*",
    "X-Requested-With": "XMLHttpRequest",
  };

  ///POST Method
  Future post({
    required String? apiRoute,
    required var data,
    required void Function(dynamic response) successResponse,
    required void Function(dynamic response) errorResponse,
  }) async {
    Response response;
    Map<String, String> headers;

    lang = await UtilShared.readStringPreference(key: keyLocale);
    token = await UtilShared.readStringPreference(key: keyToken);

    debugPrint('Token From Shared (POST Request): $token');
    debugPrint('Locale From Shard (POST Request): $lang');

    token == ''
        ? headers = {"lang": lang, ...apiHeaders}
        : headers = {"lang": lang, "Authorization": token, ...apiHeaders};

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers
        ..options.followRedirects;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.post(apiRoute!, data: data);
      successResponse(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse(e.response!.data);
      rethrow;
    }
  }

  ///PUT Method
  Future put({
    required String apiRoute,
    required var data,
    required void Function(dynamic response) successResponse,
    required void Function(dynamic response) errorResponse,
  }) async {
    Response response;
    Map<String, String> headers;

    lang = await UtilShared.readStringPreference(key: keyLocale);
    token = await UtilShared.readStringPreference(key: keyToken);

    debugPrint('Token From Shared (POST Request): $token');
    debugPrint('Locale From Shard (POST Request): $lang');

    token == ''
        ? headers = {"lang": lang, ...apiHeaders}
        : headers = {"lang": lang, "Authorization": token, ...apiHeaders};

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.put(apiRoute, data: data);
      successResponse(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse(e.response!.data);
      rethrow;
    }
  }

  ///Delete Method
  Future delete({
    required String apiRoute,
    required var data,
    required void Function(dynamic response) successResponse,
    required void Function(dynamic response) errorResponse,
  }) async {
    Response response;
    Map<String, String> headers;

    lang = await UtilShared.readStringPreference(key: keyLocale);
    token = await UtilShared.readStringPreference(key: keyToken);

    debugPrint('Token From Shared (POST Request): $token');
    debugPrint('Locale From Shard (POST Request): $lang');

    token == ''
        ? headers = {"lang": lang, ...apiHeaders}
        : headers = {"lang": lang, "Authorization": token, ...apiHeaders};

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.delete(apiRoute, data: data);
      successResponse(response.data);
    } on SocketException catch (e) {
      errorResponse(e);
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse(e.response!.data);
      rethrow;
    }
  }

  ///GET Method
  Future get({
    required String apiRoute,
    required void Function(dynamic response) successResponse,
    required void Function(dynamic response) errorResponse,
  }) async {
    Response response;
    Map<String, String> headers;

    lang = await UtilShared.readStringPreference(key: keyLocale);
    token = await UtilShared.readStringPreference(key: keyToken);

    debugPrint('Token From Shared (GET Request): $token');
    debugPrint('Locale From Shard (GET Request): $lang');

    token == ''
        ? headers = {"lang": lang, ...apiHeaders}
        : headers = {"lang": lang, "Authorization": token, ...apiHeaders};

    try {
      if (kDebugMode) {
        _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: false,
        ));
      }
      _dio
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.connectTimeout = _defaultConnectTimeout
        ..options.receiveTimeout = _defaultReceiveTimeout
        ..options.headers = headers;
      _dio.interceptors.add(RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ));
      response = await _dio.get(apiRoute);
      successResponse(response.data);
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on DioError catch (e) {
      errorResponse(e.response!.data);
      rethrow;
    }
  }
}
