import 'package:get/get.dart';

class DetailTransactionController extends GetxController {
  var nominal = 0.obs;
  var status = true.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    nominal.value = Get.arguments[0] ?? 10000;
    status.value = Get.arguments[1] ?? true;
    isLoading.value = false;
    super.onInit();
  }
}
