import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:payment_test_app/controllers/transaction/detail_transaction_controller.dart';
import 'package:payment_test_app/widget/app_bar.dart';
import 'package:payment_test_app/widget/dot_separator.dart';

class DetailTransactionPage extends StatelessWidget {
  DetailTransactionPage({Key? key}) : super(key: key);
  DetailTransactionController controller =
      Get.put(DetailTransactionController());
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: "Rp",
    decimalDigits: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      backgroundColor: AppColors.light,
    );
  }

  PreferredSizeWidget _appBar() {
    return appBar(
      title: "Rincian Transaksi",
    );
  }

  Widget _body() {
    return Obx(() => controller.isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : SafeArea(
            child: SizedBox(
                height: Get.height,
                width: Get.width,
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _alertPayment(controller.status.value),
                              const SizedBox(
                                height: 30,
                              ),
                              if (controller.status.value) _receiptPayment(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _closeBtn()
                  ],
                ))));
  }

  Widget _alertPayment(bool status) {
    return Column(
      children: [
        const SizedBox(
          height: 36,
        ),
        SizedBox(
          height: 55,
          width: 55,
          child: Icon(
            status ? IconlyBold.tick_square : IconlyBold.close_square,
            color: status ? AppColors.green : AppColors.danger,
            size: 55,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          status ? "Berhasil" : "Gagal",
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: status ? AppColors.green : AppColors.danger,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Obx(() => Text(
              currencyFormatter.format(controller.nominal.value),
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            )),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              child: SvgPicture.asset(
                "assets/svg/vector.svg",
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Top Up Saldo",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          status
              ? "Saldo berhasil masuk"
              : "Tenang saja walaupun gagal saldo \nkakak/adik tidak akan berkurang",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: status ? FontWeight.w600 : FontWeight.w500,
            color: status ? AppColors.green : AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _receiptPayment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 5,
          width: Get.width,
          color: AppColors.lightGrey,
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/one_click.png",
                    width: 78,
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  Text(
                    "BCA OneKlik",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 1,
                width: Get.width,
                color: AppColors.lightGrey,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Detail Transaksi",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    _listDetail(label: "Masuk ke Saldo", content: "p10.000"),
                    _listDetail(label: "Tanggal", content: "01 Nov 2022"),
                    _listDetail(label: "Waktu", content: "13:13"),
                    _listDetail(
                        label: "No Referensi",
                        content: "p01-221101-d207892398-j23",
                        refNumber: true),
                    _listDetail(label: "Nominal Top Up", content: "Rp10.000"),
                    _listDetail(label: "Biaya Top Up", content: "Rp.1000")
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const DotSeparator(),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleText,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Rp10.001",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.titleText,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const DotSeparator(),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 5,
          width: Get.width,
          color: AppColors.lightGrey,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget _listDetail(
      {required String label, required String content, bool? refNumber}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                child: Text(
                  content,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titleText,
                  ),
                ),
              ),
              if (refNumber == true)
                const SizedBox(
                  width: 4,
                ),
              if (refNumber == true)
                GestureDetector(
                  onTap: () {
                    Clipboard.setData(const ClipboardData(text: "content"))
                        .then((value) =>
                            Get.rawSnackbar(message: "Disalin ke clipboard"));
                  },
                  child: SizedBox(
                    width: 15,
                    child: SvgPicture.asset(
                      "assets/svg/copy.svg",
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _closeBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
      width: Get.width,
      child: ElevatedButton(
        onPressed: () {
          Get.back();
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
          child: Text("Tutup",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
        ),
      ),
    );
  }
}
