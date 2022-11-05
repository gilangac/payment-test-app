// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/serivces/service_preference.dart';
import 'package:payment_test_app/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceService.init();
  initializeDateFormatting('id', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payment-test',
      theme: lightTheme(context),
      initialRoute: AppPages.HOME,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
