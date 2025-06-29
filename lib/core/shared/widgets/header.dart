import 'dart:html' as html;

import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/app_colors.dart';

Widget header({VoidCallback? onMenu}) {
  // Detect screen width for responsive logic
  return LayoutBuilder(
    builder: (context, constraints) {
      final isMobile = constraints.maxWidth <= 650;

      return Container(
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
              onPressed: () {
                html.window.location.href = "${AppStrings.baseUrl}";
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.black,
              ),
              label: const Text(
                'Main Website',
                style: TextStyle(color: AppColors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF7E5FF),
                foregroundColor: AppColors.themeBlue,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: const BorderSide(color: Color(0xFFF7E5FF), width: 1),
                ),
              ),
            ),
            // Hamburger icon for mobile
            if (isMobile) ...[
              SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.menu, size: 30, color: Colors.white),
                tooltip: "Open navigation menu",
                onPressed: onMenu,
              ),
            ],
          ],
        ),
      );
    },
  );
}
