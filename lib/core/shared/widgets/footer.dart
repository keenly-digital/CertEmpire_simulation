import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/utils/spacer_utility.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final ScrollController? scrollController;

  const Footer({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    const footerBg = AppColors.themeBlue;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ——— Bottom Footer ———
                Container(
                  width: double.infinity,
                  color: footerBg,
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 48,
                    bottom: 14,
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth < 600) {
                        // Mobile layout
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Logo and Description
                            Column(
                              children: [
                                Image.asset(
                                  'assets/images/white-logo.png',
                                  height: 80,
                                  width: 170,
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(
                                          color: AppColors.lightSurface,
                                          fontWeight: FontManager.light,
                                          letterSpacing: 1.1,
                                          height: 1.6,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            // Helpful Links
                            _buildLinkSection(context, "HELPFUL LINKS", {
                              "About Us": "${AppStrings.baseUrl}/about-us/",
                              "Refund Policy":
                                  "${AppStrings.baseUrl}/refund-policy/",
                              "Terms & Conditions":
                                  "${AppStrings.baseUrl}/terms-conditions/",
                              "Login/Register":
                                  "${AppStrings.baseUrl}/my-account/",
                              "Privacy Policy":
                                  "${AppStrings.baseUrl}/privacy-policy/",
                              "Blogs": "${AppStrings.baseUrl}/blog/",
                              "Contact Us": "${AppStrings.baseUrl}/contact/",
                            }, center: true),
                            const SizedBox(height: 28),
                            // Top Vendors
                            _buildLinkSection(context, "TOP VENDORS", {
                              "Microsoft":
                                  "${AppStrings.baseUrl}/pdf/microsoft/",
                              "CompTIA": "${AppStrings.baseUrl}/pdf/comptia/",
                              "Amazon": "${AppStrings.baseUrl}/pdf/amazon/",
                              "Salesforce":
                                  "${AppStrings.baseUrl}/pdf/salesforce/",
                              "ISC2": "${AppStrings.baseUrl}/pdf/isc2/",
                              "CISCO":
                                  "${AppStrings.baseUrl}/pdf/cisco-exam-dumps/",
                              "Google": "${AppStrings.baseUrl}/pdf/google/",
                            }, center: true),
                            const SizedBox(height: 28),
                            // Contact Us, centered
                            Column(
                              children: [
                                FittedBox(
                                  child: Text(
                                    "CONTACT US",
                                    style: context.textTheme.titleLarge
                                        ?.copyWith(
                                          color: AppColors.lightSurface,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "sales@certempire.com",
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: AppColors.lightSurface,
                                            fontWeight: FontManager.medium,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        // Desktop/tablet: 4 columns in a Row
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Logo and description
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    'assets/images/white-logo.png',
                                    height: 150,
                                    width: 300,
                                  ),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    width: 340,
                                    child: Text(
                                      "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
                                      style: context.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: AppColors.lightSurface,
                                            fontWeight: FontManager.light,
                                            letterSpacing: 1.2,
                                            height: 1.8,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: _buildLinkSection(
                                context,
                                "HELPFUL LINKS",
                                {
                                  "About Us": "${AppStrings.baseUrl}/about-us/",
                                  "Refund Policy":
                                      "${AppStrings.baseUrl}/refund-policy/",
                                  "Terms & Conditions":
                                      "${AppStrings.baseUrl}/terms-conditions/",
                                  "Login/Register":
                                      "${AppStrings.baseUrl}/my-account/",
                                  "Privacy Policy":
                                      "${AppStrings.baseUrl}/privacy-policy/",
                                  "Blogs": "${AppStrings.baseUrl}/blog/",
                                  "Contact Us":
                                      "${AppStrings.baseUrl}/contact/",
                                },
                              ),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: _buildLinkSection(context, "TOP VENDORS", {
                                "Microsoft":
                                    "${AppStrings.baseUrl}/pdf/microsoft/",
                                "CompTIA": "${AppStrings.baseUrl}/pdf/comptia/",
                                "Amazon": "${AppStrings.baseUrl}/pdf/amazon/",
                                "Salesforce":
                                    "${AppStrings.baseUrl}/pdf/salesforce/",
                                "ISC2": "${AppStrings.baseUrl}/pdf/isc2/",
                                "CISCO":
                                    "${AppStrings.baseUrl}/pdf/cisco-exam-dumps/",
                                "Google": "${AppStrings.baseUrl}/pdf/google/",
                              }),
                            ),
                            const SizedBox(width: 40),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FittedBox(
                                    child: Text(
                                      "CONTACT US",
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(
                                            color: AppColors.lightSurface,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          "sales@certempire.com",
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                                color: AppColors.lightSurface,
                                                fontWeight: FontManager.medium,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 40),
                // Copyright
                Text(
                  "COPYRIGHT © ${DateTime.now().year} CERT EMPIRE.",
                  style: context.textTheme.labelLarge?.copyWith(
                    color: AppColors.lightSurface,
                    fontWeight: FontManager.medium,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
            // ——— Scroll-to-top FAB ———
            if (scrollController != null)
              Positioned(
                bottom: 20,
                right: 20,
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
        ),
      ],
    );
  }

  Widget _buildLinkSection(
    BuildContext context,
    String title,
    Map<String, String> links, {
    bool center = false,
  }) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              color: AppColors.lightSurface,
              fontWeight: FontManager.semiBold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in links.entries)
          InkWell(
            onTap: () => _launchURL(entry.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "•",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      entry.key,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColors.lightSurface,
                        fontWeight: FontManager.regular,
                        letterSpacing: 0.5,
                        fontSize: 15.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
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
