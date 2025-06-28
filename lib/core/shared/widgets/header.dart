import 'dart:html' as html;
import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme/app_colors.dart';

class Header extends StatelessWidget {
  final VoidCallback? onHamburgerTap;
  const Header({Key? key, this.onHamburgerTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Container(
      height: isMobile ? 54.h : 80.h,
      color: AppColors.themeBlue,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8.w : 24.w),
      child: Row(
        children: [
          // Hamburger (mobile only)
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: onHamburgerTap,
              splashRadius: 20,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          // Logo
          Padding(
            padding: EdgeInsets.only(left: isMobile ? 4.w : 0),
            child: Image.asset(
              'assets/images/CertEmpire_Logo.png',
              height: isMobile ? 28.h : (isTablet ? 42.h : 50.h),
              width: isMobile ? 80.w : (isTablet ? 120.w : 150.w),
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          // Main Website button: text+icon desktop/tablet, small button mobile
          if (!isMobile)
            ElevatedButton.icon(
              onPressed: () {
                html.window.location.href = AppStrings.baseUrl;
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
                backgroundColor: const Color(0xFFF7E5FF),
                foregroundColor: AppColors.themeBlue,
                elevation: 4,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Color(0xFFF7E5FF), width: 1),
                ),
              ),
            ),
          if (isMobile)
            // Mini "Main Website" button: icon+label compact
            TextButton.icon(
              onPressed: () {
                html.window.location.href = AppStrings.baseUrl;
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: AppColors.black,
                size: 20,
              ),
              label: const Text(
                'Main Website',
                style: TextStyle(color: AppColors.black, fontSize: 13),
              ),
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF7E5FF),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: const BorderSide(color: Color(0xFFF7E5FF), width: 1),
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size(0, 0),
              ),
            ),
        ],
      ),
    );
  }
}
