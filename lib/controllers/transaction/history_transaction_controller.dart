import 'package:get/get.dart';

class HistoryTransactionController extends GetxController {
  var dataBank = [
    {
      "bank_name": "Mandiri",
      "nominal": 10000,
      "status": true,
      "date": "2022-11-01T09:14:03"
    },
    {
      "bank_name": "BCA",
      "nominal": 20000,
      "status": true,
      "date": "2022-11-01T09:14:03"
    },
    {
      "bank_name": "Mandiri",
      "nominal": 15000,
      "status": false,
      "date": "2022-10-18T09:14:03"
    },
    {
      "bank_name": "Mandiri",
      "nominal": 35000,
      "status": false,
      "date": "2022-09-18T09:14:03"
    },
    {
      "bank_name": "Mandiri",
      "nominal": 25000,
      "status": true,
      "date": "2022-09-18T09:14:03"
    },
    {
      "bank_name": "BRI",
      "nominal": 15000,
      "status": false,
      "date": "2022-09-18T09:14:03"
    },
  ];

  @override
  void onInit() {
    super.onInit();
  }
}
