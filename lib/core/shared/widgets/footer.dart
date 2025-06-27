import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final ScrollController? scrollController;
  const Footer({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    // Set a sensible maxWidth for the whole footer on web
    final double maxFooterWidth = 1200;

    return Container(
      color: AppColors.themeBlue,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.w : 40.w,
        vertical: isMobile ? 36.h : 80.h,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxFooterWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Responsive content layout
              if (isMobile)
                ..._buildMobileFooter(context)
              else if (isTablet)
                ..._buildTabletFooter(context)
              else
                ..._buildDesktopFooter(context),
              SizedBox(height: isMobile ? 24.h : 40.h),
              Divider(color: Colors.white.withOpacity(0.2), height: 1),
              SizedBox(height: 10.h),
              Text(
                "COPYRIGHT © ${DateTime.now().year} CERT EMPIRE.",
                style: context.textTheme.labelLarge?.copyWith(
                  color: AppColors.lightSurface,
                  fontSize: isMobile ? 10.sp : 14,
                ),
                textAlign: TextAlign.center,
              ),
              if (scrollController != null) ...[
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Color(0xFF2c1e70),
                    ),
                    onPressed:
                        () => scrollController!.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMobileFooter(BuildContext context) => [
    _logoAndDescription(context, isMobile: true),
    SizedBox(height: 24.h),
    _buildLinkSection(
      context,
      "HELPFUL LINKS",
      _helpfulLinks(context),
      isMobile: true,
    ),
    SizedBox(height: 24.h),
    _buildLinkSection(
      context,
      "TOP VENDORS",
      _topVendors(context),
      isMobile: true,
    ),
    SizedBox(height: 24.h),
    _contactSection(context, isMobile: true),
  ];

  List<Widget> _buildTabletFooter(BuildContext context) => [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _logoAndDescription(context)),
        SizedBox(width: 24),
        Expanded(
          child: _buildLinkSection(
            context,
            "HELPFUL LINKS",
            _helpfulLinks(context),
          ),
        ),
      ],
    ),
    SizedBox(height: 32),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _buildLinkSection(
            context,
            "TOP VENDORS",
            _topVendors(context),
          ),
        ),
        SizedBox(width: 24),
        Expanded(child: _contactSection(context)),
      ],
    ),
  ];

  List<Widget> _buildDesktopFooter(BuildContext context) => [
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _logoAndDescription(context)),
        SizedBox(width: 32),
        Expanded(
          child: _buildLinkSection(
            context,
            "HELPFUL LINKS",
            _helpfulLinks(context),
          ),
        ),
        SizedBox(width: 32),
        Expanded(
          child: _buildLinkSection(
            context,
            "TOP VENDORS",
            _topVendors(context),
          ),
        ),
        SizedBox(width: 32),
        Expanded(child: _contactSection(context)),
      ],
    ),
  ];

  Widget _logoAndDescription(BuildContext context, {bool isMobile = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/images/white-logo.png',
          height: isMobile ? 60.h : 80,
          width: isMobile ? 120.w : 160,
        ),
        SizedBox(height: 12),
        Text(
          "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
          style: context.textTheme.bodyLarge?.copyWith(
            color: AppColors.lightSurface,
            fontWeight: FontManager.light,
            letterSpacing: 1.3,
            height: 1.5,
            fontSize: isMobile ? 12.sp : 16,
          ),
          maxLines: isMobile ? 6 : 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Map<String, String> _helpfulLinks(BuildContext context) => {
    "About Us": "${AppStrings.baseUrl}/about-us/",
    "Refund Policy": "${AppStrings.baseUrl}/refund-policy/",
    "Terms & Conditions": "${AppStrings.baseUrl}/terms-conditions/",
    "Login/Register": "${AppStrings.baseUrl}/my-account/",
    "Privacy Policy": "${AppStrings.baseUrl}/privacy-policy/",
    "Blogs": "${AppStrings.baseUrl}/blog/",
    "Contact Us": "${AppStrings.baseUrl}/contact/",
  };

  Map<String, String> _topVendors(BuildContext context) => {
    "Microsoft": "${AppStrings.baseUrl}/pdf/microsoft/",
    "CompTIA": "${AppStrings.baseUrl}/pdf/comptia/",
    "Amazon": "${AppStrings.baseUrl}/pdf/amazon/",
    "Salesforce": "${AppStrings.baseUrl}/pdf/salesforce/",
    "ISC2": "${AppStrings.baseUrl}/pdf/isc2/",
    "CISCO": "${AppStrings.baseUrl}/pdf/cisco-exam-dumps/",
    "Google": "${AppStrings.baseUrl}/pdf/google/",
  };

  Widget _buildLinkSection(
    BuildContext context,
    String title,
    Map<String, String> links, {
    bool isMobile = false,
  }) {
    // Set a hard max font size for headings/links on non-mobile (for web/desktop)
    final double headingFontSize = isMobile ? 13.sp : 20.0;
    final double linkFontSize = isMobile ? 12.sp : 15.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.lightSurface,
            fontSize: headingFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...links.entries.map(
          (entry) => Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: InkWell(
              onTap: () => _launchURL(entry.value),
              child: Row(
                children: [
                  Text(
                    "• ",
                    style: TextStyle(
                      fontSize: linkFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      entry.key,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColors.lightSurface,
                        fontWeight: FontManager.regular,
                        fontSize: linkFontSize,
                        height: 1.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _contactSection(BuildContext context, {bool isMobile = false}) {
    final double headingFontSize = isMobile ? 13.sp : 20.0;
    final double contactFontSize = isMobile ? 12.sp : 15.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CONTACT US",
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.lightSurface,
            fontSize: headingFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.mail, color: Colors.white, size: contactFontSize),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                "sales@certempire.com",
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColors.lightSurface,
                  fontWeight: FontManager.medium,
                  fontSize: contactFontSize,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint("Could not launch $url");
    }
  }
}
