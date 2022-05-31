import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/add_location_model.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/future_manager.dart';
import 'package:pams/models/get_location_response.dart';
import 'package:pams/models/single_test_response_model.dart';
import 'package:pams/models/update_location_model.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/utils/notify_user.dart';
import 'package:pams/view_models/base_vm.dart';

class ClienServiceViewModel extends BaseViewModel {
  final Reader reader;

  FutureManager<CustomerResponseModel> clientData = FutureManager();
  FutureManager<LocationResponseModel> clientLocation = FutureManager();
  FutureManager<AddLocationResponseModel> addclientLocation = FutureManager();
  FutureManager<UpdateLocationResponseModel> updateclientLocation =
      FutureManager();
  FutureManager<RunSimpleTestResponseModel> runEachDPRData = FutureManager();
  FutureManager<RunSimpleTestResponseModel> runEachFMENVData = FutureManager();
  FutureManager<RunSimpleTestResponseModel> runEachNESREAData = FutureManager();

  ClienServiceViewModel(this.reader) : super(reader) {
    getAllClients();
  }

  getAllClients() async {
    clientData.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).getAllClientData();
    if (res!.status == true) {
      clientData.onSuccess(res);

      notifyListeners();
    } else {
      clientData.onError('Error');
      notifyListeners();
    }
  }

  // getClientLocation({required String clientId}) async {
  //   clientLocation.load();
  //   notifyListeners();
  //   final res = await reader(clientServiceProvider)
  //       .getClientLocation(clientId: clientId);
  //   if (res!.status == true) {
  //     clientLocation.onSuccess(res);

  //     notifyListeners();
  //   } else {
  //     clientLocation.onError('Error');
  //     notifyListeners();
  //   }
  // }

  addClientLocation({required AddLocationRequestModel model}) async {
    addclientLocation.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).addClientLocation(model);
    if (res!.status == true) {
      addclientLocation.onSuccess(res);
      NotifyUser.showAlert(res.message!);
      notifyListeners();
    } else {
      addclientLocation.onError('Error');
      notifyListeners();
    }
  }

  // update location
  updateClientLocation(
      {required dynamic locationId,
      required String name,
      required String description}) async {
    updateclientLocation.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).updateClientLocation(
        locationId: locationId, name: name, description: description);
    if (res!.status == true) {
      updateclientLocation.onSuccess(res);
      NotifyUser.showAlert(res.message!);
      notifyListeners();
    } else {
      updateclientLocation.onError('Error');
      notifyListeners();
    }
  }

  //run each dpr test
  runEachDPRTest({
    required int Id,
    required int DPRFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    runEachDPRData.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).runEACHDPRTest(
        Id: Id,
        DPRFieldId: DPRFieldId,
        TestLimit: TestLimit,
        TestResult: TestResult);
    if (res.status == true) {
      runEachDPRData.onSuccess(res);
      getAllClients();
      NotifyUser.showAlert(res.message!);
      notifyListeners();
    } else {
      runEachDPRData.onError('Error');
      notifyListeners();
    }
  }

  //run each fmenv test
  runEachFMENVTest({
    required int Id,
    required int FMEnvFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    runEachFMENVData.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).runEACHFMENVTest(
        Id: Id,
        FMEnvFieldId: FMEnvFieldId,
        TestLimit: TestLimit,
        TestResult: TestResult);
    if (res.status == true) {
      runEachFMENVData.onSuccess(res);
      NotifyUser.showAlert(res.message!);
      notifyListeners();
    } else {
      runEachFMENVData.onError('Error');
      notifyListeners();
    }
  }

  //run each nesrea test
  runEachNESREATest({
    required int Id,
    required int NesreaFieldId,
    required dynamic TestLimit,
    required dynamic TestResult,
  }) async {
    runEachNESREAData.load();
    notifyListeners();
    final res = await reader(clientServiceProvider).runEACHNESREATest(
        Id: Id,
        NesreaFieldId: NesreaFieldId,
        TestLimit: TestLimit,
        TestResult: TestResult);
    if (res.status == true) {
      runEachNESREAData.onSuccess(res);
      NotifyUser.showAlert(res.message!);
      notifyListeners();
    } else {
      runEachNESREAData.onError('Error');
      notifyListeners();
    }
  }
}
