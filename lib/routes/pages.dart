// ignore_for_file: constant_identifier_names

import 'package:get/route_manager.dart';
import 'package:payment_test_app/views/home/home_page.dart';
import 'package:payment_test_app/views/transaction/payment_page.dart';
import 'package:payment_test_app/views/transaction/top_up_page.dart';
import 'package:payment_test_app/views/transaction/detail_transaction_page.dart';
import 'package:payment_test_app/views/transaction/history_transaction_page.dart';

part 'routes.dart';

class AppPages {
  static const HOME = _Paths.HOME;
  static const HISTORY_TRANSACTION = _Paths.HISTORY_TRANSACTION;
  static const DETAIL_TRANSACTION = _Paths.DETAIL_TRANSACTION;
  static const TOP_UP = _Paths.TOP_UP;
  static const PAYEMENT = _Paths.PAYEMENT;
}

abstract class _Paths {
  static const HOME = '/home';
  static const HISTORY_TRANSACTION = '/history-transaction';
  static const DETAIL_TRANSACTION = '/detail-transaction';
  static const TOP_UP = '/top-up';
  static const PAYEMENT = '/payment';
}
