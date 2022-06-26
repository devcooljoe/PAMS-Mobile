
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pams/styles/custom_colors.dart';

class NotifyUser {
  static showAlert(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColors.blackColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
