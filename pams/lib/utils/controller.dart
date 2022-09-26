import 'package:get/get.dart';

class PamsStateController extends GetxController {
  Rx<bool> connectionStatus = true.obs;
  Rx<bool> offlinePoint = false.obs;
}
