import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class BottomSheetHelper {
  static showError(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContentLogout(
        title, description, textAction, Category.error, onAction);
  }

  static showSuccess(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContent(
        title, description, textAction, Category.success, onAction);
  }

  static showStatusMessage(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContent(
        title, description, textAction, Category.statusMessage, onAction);
  }

  static showLogout(
      {required String title,
      required String description,
      String? textAction,
      void Function()? onAction}) {
    _bottomSheetContentLogout(
        title, description, textAction, Category.logout, onAction);
  }
}

void _bottomSheetContent(
    String title, String description, String? textAction, Category category,
    [void Function()? onAction]) {
  Get.bottomSheet(
    SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Get.textTheme.headline5,
            ),
            const SizedBox(height: 40),
            (category == Category.statusMessage)
                ? SizedBox(
                    height: Get.height * 0.2,
                    child: Center(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          child: Text(
                            description,
                            style: GoogleFonts.poppins(
                                fontSize: 14, color: AppColors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Image.asset(
                        (category == Category.success)
                            ? 'assets/images/notification_success.png'
                            : 'assets/images/notification_failed.png',
                        height: 90,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: AppColors.black),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              child: GetPlatform.isIOS
                  ? CupertinoButton.filled(
                      borderRadius: BorderRadius.circular(12),
                      onPressed: onAction ?? _onPressCTA,
                      child: Text(textAction ?? 'Oke'),
                    )
                  : ElevatedButton(
                      onPressed: onAction ?? _onPressCTA,
                      child: Text(textAction ?? 'Oke'),
                    ),
            ),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
  );
}

void _bottomSheetContentLogout(
    String title, String description, String? textAction, Category category,
    [void Function()? onAction]) {
  Get.bottomSheet(
    SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.lightGrey,
              ),
            ),
            const SizedBox(height: 24),
            Column(
              children: [
                Image.asset(
                  (category == Category.logout)
                      ? 'assets/images/logout_vector.png'
                      : 'assets/images/error_vactor.png',
                  height: 150,
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            if (category == Category.error)
              Column(
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "Sepertinya ada yang salah\n dengan sistem kami",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.lightGrey,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            const SizedBox(height: 24),
            if (category == Category.error)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  child: Text(
                    'Oke',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
              )
            else
              Container(
                width: Get.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: AppColors.danger),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: onAction ?? _onPressCTA,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Ya',
                      style: TextStyle(
                          color: AppColors.danger,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            if (category == Category.logout) const SizedBox(height: 12),
            if (category == Category.logout)
              SizedBox(
                width: double.infinity,
                child: GetPlatform.isIOS
                    ? CupertinoButton.filled(
                        borderRadius: BorderRadius.circular(12),
                        onPressed: () => Get.back(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            textAction ?? 'Batal',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(textAction ?? 'Batal',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
              ),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48), topRight: Radius.circular(48))),
    isDismissible: false,
    enableDrag: false,
    isScrollControlled: true,
  );
}

_onPressCTA() {
  if (Get.isBottomSheetOpen!) Get.back();
  Get.back();
}

enum Category { success, error, statusMessage, logout }
