// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';

Widget formInput(
    {String? initialValue,
    required String placeholder,
    required controller,
    required TextInputType inputType,
    required TextInputAction inputAction,
    required Function(String) action,
    bool secureText = false,
    bool enabled = true,
    required validator}) {
  return Column(
    children: [
      TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: action,
        keyboardType: inputType,
        textInputAction: inputAction,
        obscureText: secureText,
        enabled: enabled,
        style: GoogleFonts.poppins(fontSize: 12),
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.grey),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(color: AppColors.danger, width: 1.0),
            ),
            fillColor: AppColors.formInput,
            // focusedBorder: myfocusborder(),
            // errorBorder: myfocusErrorBorder(),
            focusedErrorBorder: myfocusErrorBorder()),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    ],
  );
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: AppColors.outline,
        width: 1,
      ));
}

OutlineInputBorder myfocusErrorBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(
        color: AppColors.danger,
        width: 1,
      ));
}
