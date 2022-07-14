import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pams/utils/controller.dart';

class ConnectionStatus {
  static Future<bool> isConnected(BuildContext context) async {
    var connectionResult = await (Connectivity().checkConnectivity());

    if (connectionResult == ConnectivityResult.mobile)
      return true;
    else if (connectionResult == ConnectivityResult.wifi)
      return true;
    else {
      Fluttertoast.showToast(msg: "Check Network Connection !!!");
      return false;
    }
  }

  static void dataIsConnected() async {
    PamsStateController controller = Get.put(PamsStateController());
    try {
      final result = await InternetAddress.lookup('example.com');
      print("Main Result: $result");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        controller.connectionStatus.value = true;
      } else {
        controller.connectionStatus.value = false;
      }
    } on SocketException catch (_) {
      controller.connectionStatus.value = false;
    } catch (e) {
      print('Error: $e');
      controller.connectionStatus.value = false;
    }
  }
}
