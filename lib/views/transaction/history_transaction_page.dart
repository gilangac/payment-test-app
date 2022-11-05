import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:payment_test_app/controllers/transaction/history_transaction_controller.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/widget/app_bar.dart';

class HistoryTransactionPage extends StatelessWidget {
  HistoryTransactionPage({Key? key}) : super(key: key);
  HistoryTransactionController controller =
      Get.put(HistoryTransactionController());
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
      title: "Riwayat Transaksi",
    );
  }

  Widget _body() {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: Get.height,
        child: ListView.builder(
            itemCount: controller.dataBank.length,
            padding: const EdgeInsets.only(top: 27),
            itemBuilder: (context, index) {
              var indexData = "";
              var besforeIndexData = "";
              var afterIndexData = "";
              if (controller.dataBank.isNotEmpty) {
                indexData = (controller.dataBank[index]['date']
                    .toString()
                    .split(" "))[0];
                if (index > 0) {
                  besforeIndexData = (controller.dataBank[index - 1]['date']
                      .toString()
                      .split(" "))[0];
                }
                if (index + 1 < controller.dataBank.length) {
                  afterIndexData = (controller.dataBank[index + 1]['date']
                      .toString()
                      .split(" "))[0];
                }
              }
              return SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (indexData != besforeIndexData)
                      Column(
                        children: [
                          Text(
                            DateFormat("EEEE, dd MMM yyyy", "id").format(
                                DateTime.parse(controller.dataBank[index]
                                        ['date']
                                    .toString())),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppPages.DETAIL_TRANSACTION,
                          arguments: [
                            controller.dataBank[index]['nominal'],
                            controller.dataBank[index]['status']
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            child: SvgPicture.asset(
                              "assets/svg/vector.svg",
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Top Up Saldo",
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      currencyFormatter.format(controller
                                          .dataBank[index]['nominal']),
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: controller.dataBank[index]
                                                        ['status']
                                                    .toString() ==
                                                "true"
                                            ? AppColors.green
                                            : AppColors.danger,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  controller.dataBank[index]['bank_name']
                                      .toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                if (indexData == afterIndexData)
                                  Container(
                                    height: 1,
                                    color: AppColors.lightGrey,
                                  ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          // Text(
                          //   "Rp20.000",
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.w500,
                          //     color: AppColors.green,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
