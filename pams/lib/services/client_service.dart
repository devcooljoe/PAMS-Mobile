import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientServiceImplementation extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();

  final getAllClientURL = '/Client/GetAllClient';
  ClientServiceImplementation(this.reader) : super(reader);

  //load all clients
  Future<CustomerResponseModel?> getAllClientData(int? pageNumber) async {
    final params = {
      'pageSize': 10,
      'pageNumber': pageNumber,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var api = prefs.getString('apiToken');
    final response = await getHttp(getAllClientURL, params: params, token: api);
    if (response.responseCodeError == null) {
      return CustomerResponseModel.fromJson(response.data);
    } else {
      return CustomerResponseModel(status: false);
    }
  }
}
