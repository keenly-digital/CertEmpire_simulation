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
                // ——— CTA Section ———
                // Container(
                //   width: double.infinity,
                //   padding: const EdgeInsets.all(20),
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [Color(0xFFc9a0ff), Color(0xFF7e3ff2)],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "WANT TO DO MORE WITH YOUR PURCHASE?",
                //               style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.deepPurple.shade900,
                //               ),
                //             ),
                //             const SizedBox(height: 10),
                //             const Text(
                //               "Create Flashcards, Create Random Quizzes, And Make Important Notes From Your File.",
                //               style: TextStyle(fontSize: 14),
                //             ),
                //             const SizedBox(height: 10),
                //             Wrap(
                //               crossAxisAlignment: WrapCrossAlignment.center,
                //               children: const [
                //                 Text(
                //                   "Connect With ",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //                 Text(
                //                   "QuizSimulator",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     color: Colors.purple,
                //                     fontWeight: FontWeight.bold,
                //                     decoration: TextDecoration.underline,
                //                   ),
                //                 ),
                //                 Text(
                //                   " Now!",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ),
                //       ElevatedButton(
                //         onPressed: () {},
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.deepPurple,
                //           padding: const EdgeInsets.symmetric(
                //             horizontal: 30,
                //             vertical: 10,
                //           ),
                //         ),
                //         child: const Text("Connect"),
                //       ),
                //     ],
                //   ),
                // ),

                // ——— Bottom Footer ———
                Container(
                  width: double.infinity,
                  color: footerBg,
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 80,
                    bottom: 14,
                  ),
                  child: Column(
                    children: [
                      // Four columns in one row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Logo on top, description below
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
                                  width: 365,
                                  child: Text(
                                    "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(
                                          color: AppColors.lightSurface,
                                          fontWeight: FontManager.light,
                                          letterSpacing: 1.5,
                                          height: 2,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 40),

                          // Helpful Links
                          Expanded(
                            child: _buildLinkSection(context, "HELPFUL LINKS", {
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
                            }),
                          ),

                          const SizedBox(width: 40),

                          // Top Vendors
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

                          // Contact Us
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
                                    Icon(
                                      Icons.mail,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 8),
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
                      ),

                      const SizedBox(height: 80),

                      // Copyright
                      Text(
                        "COPYRIGHT © ${DateTime.now().year} CERT EMPIRE.",
                        style: context.textTheme.labelLarge?.copyWith(
                          color: AppColors.lightSurface,
                        ),
                      ),
                    ],
                  ),
                ),
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
        // SpacerUtil.verticalLarge(),
        // SpacerUtil.verticalXLarge(),
      ],
    );
  }

  Widget _buildLinkSection(
    BuildContext context,
    String title,
    Map<String, String> links,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            title,
            style: context.textTheme.titleLarge?.copyWith(
              color: AppColors.lightSurface,
            ),
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in links.entries)
          InkWell(
            onTap: () => _launchURL(entry.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline:
                    TextBaseline
                        .alphabetic, // Align texts based on their baseline
                children: [
                  Text(
                    "• ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      entry.key,
                      textAlign: TextAlign.start,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: AppColors.lightSurface,
                        fontWeight: FontManager.regular,
                      ),
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
