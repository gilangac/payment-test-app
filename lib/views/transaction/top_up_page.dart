import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:payment_test_app/controllers/transaction/top_up_controller.dart';
import 'package:payment_test_app/widget/form_input.dart';
import 'package:payment_test_app/widget/radio_top_up.dart';

import '../../widget/app_bar.dart';

class TopUpPage extends StatelessWidget {
  TopUpPage({Key? key}) : super(key: key);
  TopUpController controller = Get.put(TopUpController());
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: "Rp",
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
        backgroundColor: AppColors.light,
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return appBar(
      title: "Metode Top Up",
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 27, 24, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                      color: AppColors.white),
                  child: TabBar(
                    overlayColor: MaterialStateProperty.all(
                        AppColors.primaryColor.withOpacity(0.5)),
                    isScrollable: false,
                    unselectedLabelColor: AppColors.black,
                    unselectedLabelStyle: GoogleFonts.poppins(
                        fontSize: 12, fontWeight: FontWeight.w600),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                    indicatorWeight: 0,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.primaryColor),
                    tabs: [
                      _tabBar(
                        "Instan",
                      ),
                      _tabBar("Metode lain"),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: TabBarView(
                  children: [_instantMethod(), _otherMethod()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _tabBar(String label) {
    return Container(
      height: 38,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Tab(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  Widget _instantMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pilih Nominal Top Up",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 14,
                            crossAxisSpacing: 8,
                            childAspectRatio: 3 / 1.15),
                    itemBuilder: (_, index) {
                      return Obx(() => RadioTopUp<int>(
                            value: index,
                            groupValue: controller.valueTopUp.value,
                            leading: currencyFormatter
                                .format(controller.dataMenuTopUp[index]),
                            onChanged: (value) {
                              controller.valueTopUp.value = value!;
                              controller.menuSelected.value =
                                  controller.dataMenuTopUp[index];
                              controller.nominalFC.clear();
                            },
                          ));
                    },
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    "Atau masukan nominal top up disini",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  formInput(
                      placeholder: "Minimal Rp10.000",
                      controller: controller.nominalFC,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.done,
                      action: (value) {
                        if (value != '') {
                          controller.valueTopUp.value = 6;
                          controller.menuSelected.value =
                              int.parse(value.toString());
                        }
                      },
                      validator: (value) {
                        if (value != "" &&
                            int.parse(value.toString()) < 10000) {
                          return 'Minimal Top Up Rp10.000';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
        _nextBtn()
      ],
    );
  }

  Widget _otherMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pilih Metode",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: AppColors.primaryColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 28,
                      width: 28,
                      child: SvgPicture.asset(
                        "assets/svg/shop.svg",
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Indomaret / Alfamart",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    const Icon(IconlyLight.arrow_right_2)
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 2, color: AppColors.primaryColor)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 28,
                      width: 28,
                      child: SvgPicture.asset(
                        "assets/svg/hp.svg",
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      "Internet / Mobile Banking",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const Spacer(),
                    const Icon(IconlyLight.arrow_right_2)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _nextBtn() {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
          width: Get.width,
          child: ElevatedButton(
            onPressed: (controller.menuSelected.value < 10000)
                ? null
                : () => controller.onPay(),
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
              child: Text("Lanjut",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
            ),
          ),
        ));
  }
}
