// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment_test_app/constant/colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class SnackBarHelper {
  static showError({required String description, SnackPosition? position}) {
    Get.showSnackbar(
      GetBar(
        icon: SvgPicture.asset(
          "assets/svg/icon/close-circle.svg",
          color: AppColors.white,
          height: 16,
        ),
        backgroundColor: AppColors.danger,
        message: description,
        duration: const Duration(seconds: 5),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: position ?? SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        borderRadius: 4,
        mainButton: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Feather.x,
              size: 20,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  static showSucces({required String description, SnackPosition? position}) {
    Get.showSnackbar(
      GetBar(
        icon: SvgPicture.asset(
          "assets/svg/icon/check-circle.svg",
          color: AppColors.white,
          height: 16,
        ),
        backgroundColor: AppColors.success,
        message: description,
        duration: const Duration(seconds: 5),
        mainButton: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Feather.x,
              size: 20,
              color: AppColors.white,
            ),
          ),
        ),
        snackStyle: SnackStyle.FLOATING,
        snackPosition: position ?? SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        borderRadius: 4,
      ),
    );
  }
}
