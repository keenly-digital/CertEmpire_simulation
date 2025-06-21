import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';

Widget header() {
  return // Scrollable header
  Container(
    height: 80.h,
    color: AppColors.themeBlue,
    padding: EdgeInsets.symmetric(horizontal: 16.w),
    child: Row(
      children: [
        Image.asset(
          'assets/images/CertEmpire_Logo.png',
          height: 50.h,
          width: 150.h,
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF2C027E)),
          label: const Text(
            'Back',
            style: TextStyle(
              color: Color(0xFF2C027E),
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            // button fill
            foregroundColor: AppColors.themeBlue,
            // splash & hover color
            elevation: 4,
            // slight shadow
            padding: EdgeInsets.symmetric(
              // comfortable touch target
              horizontal: 16.w,
              vertical: 12.h,
            ),
            shape: RoundedRectangleBorder(
              // pill‐ish corners
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFF2C027E), width: 1),
            ),
          ),
        ),
      ],
    ),
  );
  // File-level header
}
