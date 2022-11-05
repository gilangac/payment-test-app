import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payment_test_app/constant/colors.dart';

class RadioTopUp<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T?> onChanged;

  const RadioTopUp({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: _customRadioButton,
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          leading,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? AppColors.white : AppColors.grey),
        ),
      ),
    );
  }
}
