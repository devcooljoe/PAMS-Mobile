import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pams/utils/network.dart' as _networkutils;
import 'package:pams/http/custom_exception.dart';
import 'dart:developer' as _logger;

import 'package:pams/models/formatted_response.dart';

abstract class ApiManager {
  late Dio dio;

  final baseURL = 'http://sethlab-001-site1.itempurl.com/api/v1';

  ApiManager() {
    final options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: 90 * 1000, // 60 seconds
      receiveTimeout: 90 * 1000, // 90 seconds
    );

    dio = Dio(options);
  }

  //GET
  Future<FormattedResponse> getHttp(String route, {Map<String, dynamic>? params, bool formdata = false, dynamic token}) async {
    setHeader(formdata: formdata, token: token);
    params?.removeWhere((key, value) => value == null);
    final fullRoute = '$baseURL$route';
    return makeRequest(dio.get(
      fullRoute,
      queryParameters: params,
    ));
  }

  //POST
  Future<FormattedResponse> postHttp(String route, dynamic body, {Map<String, dynamic>? params, bool formdata = false, bool formEncoded = false, dynamic token}) async {
    setHeader(formdata: formdata, formEncoded: formEncoded, token: token);
    params?.removeWhere((key, value) => value == null);
    //body?.removeWhere((key, value) => value == null);
    final fullRoute = '$baseURL$route';
    if (formdata) {
      body = FormData.fromMap(body as Map<String, dynamic>);
    }

    return makeRequest(dio.post(
      fullRoute,
      data: body,
      onSendProgress: _networkutils.showLoadingProgress,
      onReceiveProgress: _networkutils.showLoadingProgress,
      queryParameters: params,
    ));
  }

  //PUT
  Future putHttp(String route, body, {Map<String, dynamic>? params, dynamic token}) async {
    setHeader(token: token);
    params?.removeWhere((key, value) => value == null);
    //body?.removeWhere((key, value) => value == null);
    final fullRoute = '$baseURL$route';

    return makeRequest(dio.put(
      fullRoute,
      data: body,
      onSendProgress: _networkutils.showLoadingProgress,
      onReceiveProgress: _networkutils.showLoadingProgress,
      queryParameters: params,
    ));
  }

  //DELETE
  Future deleteHttp(String route, {Map<String, dynamic>? params, dynamic token}) async {
    setHeader(token: token);
    params?.removeWhere((key, value) => value == null);
    final fullRoute = '$baseURL$route';

    return makeRequest(dio.delete(
      fullRoute,
      queryParameters: params,
    ));
  }

  Future<FormattedResponse> makeRequest(Future<Response> future) async {
    Response? response;
    try {
      response = await future;
      if (kDebugMode) {
        _logger.log('code ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        _logger.log('HTTP SERVICE ERROR MESSAGE: ${e.message}');
      }
      if (e.type == DioErrorType.connectTimeout || e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout) {
        return FormattedResponse(
          // data: e.response!.data,
          responseCodeError: "Connection Timeout",
          success: false,
          statusCode: e.response?.statusCode,
        );
      } else if (e.type == DioErrorType.other) {
        if (e.message.contains('SocketException')) {
          return FormattedResponse(
            data: response?.data,
            responseCodeError: "Oops! An error occured. Please check your internet and try again.",
            success: false,
            // statusCode: e.response!.statusCode,
          );
        }
      } else if (e.response!.statusCode == 401) {
        /// Get.offAll(() => AuthPage());
        // _navigationService.navigateAndClearHistory(Routes.authScreen);
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Session Expired",
          success: false,
          statusCode: e.response!.statusCode,
        );
      } else if (e.response!.statusCode == 404) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Oops! Resource not found",
          success: false,
          statusCode: e.response!.statusCode,
        );
      } else if (e.response!.statusCode == 500 || e.response!.statusCode == 403) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "Oops! It's not you, it's us. Give us a minute and then try again.",
          success: false,
          statusCode: e.response!.statusCode,
        );
      } else if (e.response!.statusCode == 400) {
        return FormattedResponse(
          data: e.response?.data,
          success: false,
          statusCode: e.response!.statusCode,
        );
      } else if (e.type == DioErrorType.response || e.type == DioErrorType.other) {
        return FormattedResponse(
          data: e.response?.data,
          responseCodeError: "${e.error} - ${e.message}",
          success: false,
          statusCode: e.response!.statusCode,
        );
      }
      //ErrorManager.parseError(e);
    } catch (err) {
      if (err is DioError) {
        throw const CustomException('Something went wrong');
      }
    }
    return FormattedResponse(
      data: response?.data,
      success: "${response?.statusCode}".startsWith('2'),
      statusCode: response!.statusCode,
    );
  }

  setHeader({bool formdata = false, bool formEncoded = false, dynamic token}) async {
    final Map<String, dynamic> header = {
      'content-type': formdata
          ? 'multipart/form-data'
          : formEncoded
              ? 'application/x-www-form-urlencoded'
              : 'application/json',
      // 'AppID': appID,
      // 'AppKey': apiKey,
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
    // if (await read(secureStorageProvider).hasToken()) {
    //   header['Authorization'] =
    //       'Bearer ${await read(secureStorageProvider).getAccessToken()}';
    // }

    dio.options.headers.addAll(header);
  }

  void dispose() {
    dio.clear();
    dio.close(force: true);
  }

  clearHeaders() {
    dio.options.headers.clear();
  }
}
