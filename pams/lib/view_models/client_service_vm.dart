import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pams/models/add_location_model.dart';
import 'package:pams/models/add_location_request_model.dart';
import 'package:pams/models/customer_response_model.dart';
import 'package:pams/models/future_manager.dart';
import 'package:pams/models/get_location_response.dart';
import 'package:pams/models/update_location_model.dart';
import 'package:pams/providers/clients_data_provider.dart';
import 'package:pams/view_models/base_vm.dart';

class ClienServiceViewModel extends BaseViewModel {
  final Reader reader;

  FutureManager<CustomerResponseModel> clientData = FutureManager();
  FutureManager<LocationResponseModel> clientLocation = FutureManager();
  FutureManager<AddLocationResponseModel> addclientLocation = FutureManager();
  FutureManager<UpdateLocationResponseModel> updateclientLocation =
      FutureManager();

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

      notifyListeners();
    } else {
      addclientLocation.onError('Error');
      notifyListeners();
    }
  }

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

      notifyListeners();
    } else {
      updateclientLocation.onError('Error');
      notifyListeners();
    }
  }
}
