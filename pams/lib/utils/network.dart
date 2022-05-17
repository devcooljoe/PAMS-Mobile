import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pams/http/custom_exception.dart';

void checkForNetworkExceptions(Response response) {
  if (response.statusCode! < 200 || response.statusCode! >= 400) {
    throw const CustomException('Failed to connect to internet');
  }
}

void showLoadingProgress(received, total) {
  if (total != -1) {
    if (kDebugMode) {
      debugPrint('${(received / total * 100).toStringAsFixed(0)}%');
    }
  }
}

dynamic decodeResponseBodyToJson(String body) {
  try {
    final data = convert.jsonDecode(body);
    return data;
  } on FormatException catch (e) {
    throw CustomException(e.message);
  }
}
