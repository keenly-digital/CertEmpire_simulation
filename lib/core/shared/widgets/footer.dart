import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final purpleGradient = const LinearGradient(
      colors: [Color(0xFFc9a0ff), Color(0xFF7e3ff2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Column(
      children: [
        // Top Call-to-Action Section
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(gradient: purpleGradient),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        color: Colors.deepPurple[900],
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
                          " Now !",
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

        // Footer Section
        Container(
          color: const Color(0xFF2c1e70),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Description
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.shield, size: 40, color: Colors.white),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "CERTEMPIRE is your one-stop shop to access IT Certification Exam Dumps. We have helped thousands of people achieve their dreams of becoming certified in their desired certifications through exam dumps that surely appear in exams. We can help you achieve your goals too.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // Links and Contact
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Helpful Links
                  _buildLinkSection("HELPFUL LINKS", {
                    "About Us": "https://www.google.com/search?q=google+meet&rlz=1C1GCEU_en-GBPK1127PK1127&oq=google&gs_lcrp=EgZjaHJvbWUqDggAEEUYJxg7GIAEGIoFMg4IABBFGCcYOxiABBiKBTIYCAEQLhhDGIMBGMcBGLEDGNEDGIAEGIoFMhIIAhAAGEMYgwEYsQMYgAQYigUyBggDEEUYPDIGCAQQRRg8MgYIBRBFGDwyBggGEEUYQTIGCAcQRRhB0gEHNzg3ajBqN6gCALACAA&sourceid=chrome&ie=UTF-8",
                    "Refund Policy": "https://yourdomain.com/refund",
                    "Terms & Conditions": "https://yourdomain.com/terms",
                    "Login/Register": "https://yourdomain.com/login",
                    "Privacy Policy": "https://yourdomain.com/privacy",
                    "Blogs": "https://yourdomain.com/blogs",
                    "Contact Us": "https://yourdomain.com/contact",
                  }),
                  const SizedBox(width: 30),

                  // Top Vendors
                  _buildLinkSection("TOP VENDORS", {
                    "Microsoft": "",
                    "CompTIA": "",
                    "Amazon": "",
                    "Salesforce": "",
                    "ISC2": "",
                    "CISCO": "",
                    "Google": "",
                  }),
                  const SizedBox(width: 30),

                  // Contact
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "CONTACT US",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.mail, color: Colors.white, size: 16),
                            SizedBox(width: 5),
                            Text(
                              "sales@certempire.com",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildLinkSection(String title, Map<String, String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          for (var entry in links.entries)
            InkWell(
              onTap: () => _launchURL(entry.value),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  "• ${entry.key}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      debugPrint("Could not launch $url");
    }
  }
}
