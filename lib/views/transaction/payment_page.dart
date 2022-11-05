import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:payment_test_app/controllers/home/home_controller.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/serivces/service_preference.dart';
import 'package:payment_test_app/widget/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  int progressValue = 0;
  int nominalTopUp = Get.arguments[0] ?? 0;
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: isLoading ? null : _closeBtn(),
    );
  }

  PreferredSizeWidget _appBar() {
    return appBar(title: "Pembayaran", enableLeading: false, canBack: false);
  }

  Widget _body() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Stack(
          children: [
            Stack(
              children: <Widget>[
                WebView(
                  key: _key,
                  initialUrl: Get.arguments[1] ?? "",
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (value) {
                    setState(() {
                      progressValue = value;
                    });
                  },
                  onPageFinished: (finish) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                isLoading
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 12),
                            Text(
                              "Memuat $progressValue%",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Stack(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _closeBtn() {
    return isLoading
        ? Container()
        : Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            width: Get.width,
            child: ElevatedButton(
              onPressed: () {
                int currentSaldo = PreferenceService.getSaldo() ?? 0;
                int afterPaySaldo = currentSaldo + nominalTopUp;
                PreferenceService.setSaldo(afterPaySaldo);
                HomeController homeController = Get.find();
                homeController.onRefresh();
                Get.offNamed(AppPages.DETAIL_TRANSACTION,
                    arguments: [nominalTopUp, true]);
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text("Selesai",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    )),
              ),
            ),
          );
  }
}
