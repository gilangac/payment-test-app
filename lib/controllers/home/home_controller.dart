import 'dart:async';

import 'package:get/get.dart';
import 'package:payment_test_app/serivces/service_preference.dart';

class HomeController extends GetxController {
  var saldo = 0.obs;
  @override
  void onInit() {
    Timer(const Duration(milliseconds: 100), () => onRefresh());
    super.onInit();
  }

  void onRefresh() {
    saldo.value = PreferenceService.getSaldo() ?? 0;
  }
}
