import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:payment_test_app/controllers/home/home_controller.dart';
import 'package:payment_test_app/routes/pages.dart';
import 'package:payment_test_app/serivces/service_preference.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id',
    symbol: "Rp",
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Column(
      children: [
        Stack(
          children: [
            Image.asset("assets/images/rangkul-ayo-pramuka.png"),
            Positioned(
                top: 0,
                child: Container(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      child: Row(
                        children: [
                          Icon(
                            Feather.arrow_left,
                            color: AppColors.white,
                            size: 24,
                          ),
                          Spacer(),
                          Icon(
                            Feather.more_horizontal,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    )))
          ],
        ),
        const Spacer(),
        Container(
            width: Get.width,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Container(
              width: Get.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: AppColors.primaryColor),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 19,
                                  width: 19,
                                  child: SvgPicture.asset(
                                    "assets/svg/wallet.svg",
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Saldo",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Obx(() => Text(
                                  currencyFormatter
                                      .format(controller.saldo.value),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.black,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppPages.HISTORY_TRANSACTION),
                      child: Container(
                        color: Colors.transparent,
                        height: 54,
                        width: 54,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: SvgPicture.asset(
                                  "assets/svg/document.svg",
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Riwayat",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppPages.TOP_UP),
                      child: Container(
                        color: Colors.transparent,
                        height: 54,
                        width: 54,
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 28,
                                width: 28,
                                child: SvgPicture.asset(
                                  "assets/svg/vector.svg",
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Top Up",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        Container(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                _listMenu("profile", "Ubah Profile"),
                _listMenu("lock", "Privasi"),
                _listMenu("security", "Keamanan"),
                _listMenu("group", "Pengguna"),
                _listMenu("info", "Tentang"),
                GestureDetector(
                    onTap: () {
                      PreferenceService.clear();
                      controller.onRefresh();
                    },
                    child: _listMenu("logout", "Keluar")),
              ],
            ),
          ),
        )
      ],
    ));
  }

  Widget _listMenu(String icon, String label) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                "assets/svg/$icon.svg",
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              width: 28,
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.titleText,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
