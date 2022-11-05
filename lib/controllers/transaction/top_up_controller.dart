import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payment_test_app/controllers/base/service_controller.dart';
import 'package:payment_test_app/controllers/home/home_controller.dart';
import 'package:payment_test_app/helpers/dialog_helper.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/serivces/service_preference.dart';
import 'package:payment_test_app/serivces/service_provider.dart';

class TopUpController extends GetxController with ServiceController {
  var valueTopUp = 6.obs;
  var menuSelected = 0.obs;
  var nominalInput = 0.obs;
  final nominalFC = TextEditingController();

  var dataMenuTopUp = [10000, 20000, 50000, 100000, 200000, 500000];

  onPay() async {
    DialogHelper.showLoading();
    var orderId = DateTime.now().toIso8601String();
    try {
      var response = await ServiceProvider.postData("/charge/", data: {
        "transaction_details": {
          "order_id": orderId,
          "gross_amount": menuSelected.value
        },
        "item_details": [
          {
            "id": "A01",
            "price": menuSelected.value,
            "quantity": 1,
            "name": "Top Up Saldo Ayo Pay"
          }
        ],
        "customer_details": [
          {
            "email": "tester@example.com",
            "first_name": "Top Up Saldo Ayo Pay",
            "last_name": "",
            "phone": "628112341234"
          }
        ]
      }).catchError(handleError);

      if (response == null) {
        return;
      } else {
        if (response['redirect_url'] != null) {
          Get.back();
          print(response['redirect_url']);
          Get.offNamed(AppPages.PAYEMENT + orderId,
              arguments: [menuSelected.value, response['redirect_url']]);
        } else {
          Get.offNamed(AppPages.DETAIL_TRANSACTION,
              arguments: [menuSelected.value, false]);
        }
      }
    } finally {}
  }
}
