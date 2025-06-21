import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  /// Pass your page's ScrollController here to enable the “scroll to top” button
  final ScrollController? scrollController;

  const Footer({Key? key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const footerBg = AppColors.themeBlue;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ——— CTA Section ———
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFc9a0ff), Color(0xFF7e3ff2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WANT TO DO MORE WITH YOUR PURCHASE?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Create Flashcards, Create Random Quizzes, And Make Important Notes From Your File.",
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: const [
                            Text(
                              "Connect With ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "QuizSimulator",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              " Now!",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    child: const Text("Connect"),
                  ),
                ],
              ),
            ),

            // ——— Bottom Footer ———
            Container(
              width: double.infinity,
              color: footerBg,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
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
                            Text(
                              "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 13,
                                height: 1.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 40),

                      // Helpful Links
                      Expanded(
                        child: _buildLinkSection("HELPFUL LINKS", {
                          "About Us":
                              "https://staging2.certempire.com/about-us/",
                          "Refund Policy":
                              "https://staging2.certempire.com/refund-policy/",
                          "Terms & Conditions":
                              "https://staging2.certempire.com/terms-conditions/",
                          "Login/Register":
                              "https://staging2.certempire.com/my-account/",
                          "Privacy Policy":
                              "https://staging2.certempire.com/privacy-policy/",
                          "Blogs": "https://staging2.certempire.com/blog/",
                          "Contact Us":
                              "https://staging2.certempire.com/contact/",
                        }),
                      ),

                      const SizedBox(width: 40),

                      // Top Vendors
                      Expanded(
                        child: _buildLinkSection("TOP VENDORS", {
                          "Microsoft":
                              "https://staging2.certempire.com/pdf/microsoft/",
                          "CompTIA":
                              "https://staging2.certempire.com/pdf/comptia/",
                          "Amazon":
                              "https://staging2.certempire.com/pdf/amazon/",
                          "Salesforce":
                              "https://staging2.certempire.com/pdf/salesforce/",
                          "ISC2": "https://staging2.certempire.com/pdf/isc2/",
                          "CISCO":
                              "https://staging2.certempire.com/pdf/cisco-exam-dumps/",
                          "Google":
                              "https://staging2.certempire.com/pdf/google/",
                        }),
                      ),

                      const SizedBox(width: 40),

                      // Contact Us
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "CONTACT US",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: const [
                                Icon(Icons.mail, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  "sales@certempire.com",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
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
                  Center(
                    child: Text(
                      "COPYRIGHT © ${DateTime.now().year} CERT EMPIRE.",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
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
              child: const Icon(Icons.arrow_upward, color: Color(0xFF2c1e70)),
              onPressed:
                  () => scrollController!.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildLinkSection(String title, Map<String, String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in links.entries)
          InkWell(
            onTap: () => _launchURL(entry.value),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "• ",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: entry.key,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
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
