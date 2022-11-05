// ignore_for_file: constant_identifier_names

part of 'pages.dart';

class AppRoutes {
  static const INITIAL = AppPages.HOME;

  static final pages = [
    GetPage(name: _Paths.HOME, page: () => HomePage()),
    GetPage(
        name: _Paths.HISTORY_TRANSACTION,
        page: () => HistoryTransactionPage()),
    GetPage(
        name: _Paths.DETAIL_TRANSACTION, page: () => DetailTransactionPage()),
    GetPage(name: _Paths.TOP_UP, page: () => TopUpPage()),
    GetPage(name: _Paths.PAYEMENT + ':payment', page: () => PaymentPage()),
  ];
}
