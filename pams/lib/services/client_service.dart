import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:pams/http/api_manager.dart';
import 'package:pams/models/add_location_model.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/get_location_response.dart';
import 'package:pams/models/update_location_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClientServiceImplementation extends ApiManager {
  final Reader reader;
  GetStorage box = GetStorage();

  final getAllClientURL = '/Client/GetAllClient';
  final getClientLocaionUrl =
      '/FieldScientistAnalysisNesrea/get-all-Sample-locations-for-a-Client';
  final addClientLocationURL =
      '/FieldScientistAnalysisNesrea/add-client-location';
  final deleteClientLocationUrl =
      '/FieldScientistAnalysisNesrea/delete-a-client-sample-location/';
  ClientServiceImplementation(this.reader) : super(reader);

  //load all clients
  Future<CustomerResponseModel?> getAllClientData(int? pageNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = box.read('token');
    final response = await getHttp(
        getAllClientURL + '?pageSize=10&pageNumber=$pageNumber',
        token: token);
    if (response.responseCodeError == null) {
      return CustomerResponseModel.fromJson(response.data);
    } else {
      return CustomerResponseModel(status: false);
    }
  }

  // get client location
  Future<LocationResponseModel?> getClientLocation(
      {required String clientId}) async {
    var token = box.read('token');
    final response =
        await getHttp(getClientLocaionUrl + 'clientId=$clientId', token: token);
    if (response.responseCodeError == null) {
      return LocationResponseModel.fromJson(response.data);
    } else {
      return LocationResponseModel(status: false);
    }
  }

  ///Update location
  Future<UpdateLocationResponseModel?> updateClientLocation(
      int locationId, String name, String description) async {
    var token = box.read('token');
    final response = await putHttp(
        "/FieldScientistAnalysisNesrea/Update-a-client-sample-location?SampleLocationId=$locationId&Name=$name&Description=$description",
        null,
        token: token);
    if (response.responseCodeError == null) {
      return UpdateLocationResponseModel.fromJson(response.data);
    } else {
      return UpdateLocationResponseModel(status: false);
    }
  }

  Future<Map<String, dynamic>?> deleteClientLocation(
    int locationId,
  ) async {
    var token = box.read('token');
    final response =
        await deleteHttp(addClientLocationURL + '$locationId', token: token);
    if (response.responseCodeError == null) {
      return jsonDecode(response.data);
    } else {
      return jsonDecode(response.data);
    }
  }

  Future<AddLocationResponseModel?> addClientLocation(
      AddLocationRequestModel model) async {
    var token = box.read('token');
    final response =
        await postHttp(addClientLocationURL, model.toJson(), token: token);
    if (response.responseCodeError == null) {
      return AddLocationResponseModel.fromJson(response.data);
    } else {
      return AddLocationResponseModel(status: false);
    }
  }
}
