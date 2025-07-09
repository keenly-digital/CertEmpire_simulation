import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ExplanationSection extends StatelessWidget {
  final String explanation;
  final double fontSize;
  final double headingFontSize;
  final Color? textColor;
  final Color? headingColor;

  const ExplanationSection({
    Key? key,
    required this.explanation,
    this.fontSize = 15.5,
    this.headingFontSize = 16.5,
    this.textColor,
    this.headingColor,
  }) : super(key: key);

  // --- Helper: Make links clickable in a block of text ---
  Widget clickableTextBlock(
    String text, {
    TextStyle? style,
    TextStyle? linkStyle,
  }) {
    final urlRegExp = RegExp(r'(https?:\/\/[^\s]+)');
    final spans = <TextSpan>[];
    int last = 0;
    final matches = urlRegExp.allMatches(text);
    for (final match in matches) {
      if (match.start > last) {
        spans.add(
          TextSpan(text: text.substring(last, match.start), style: style),
        );
      }
      final url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style:
              linkStyle ??
              style?.copyWith(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
          recognizer:
              TapGestureRecognizer()
                ..onTap = () async {
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
        ),
      );
      last = match.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: style));
    }
    return RichText(text: TextSpan(children: spans));
  }

  @override
  Widget build(BuildContext context) {
    final whyIncorrectKey = "Why Incorrect Options are Wrong:";
    final referencesKey = "References:";

    String beforeWhy = "";
    String whySection = "";
    String referencesSection = "";

    int whyIndex = explanation.indexOf(whyIncorrectKey);
    int refIndex = explanation.indexOf(referencesKey);

    if (whyIndex == -1 && refIndex == -1) {
      beforeWhy = explanation; // Only explanation, no headings
    } else if (whyIndex != -1 && (refIndex == -1 || whyIndex < refIndex)) {
      beforeWhy = explanation.substring(0, whyIndex).trim();
      if (refIndex != -1) {
        whySection =
            explanation
                .substring(whyIndex + whyIncorrectKey.length, refIndex)
                .trim();
        referencesSection =
            explanation.substring(refIndex + referencesKey.length).trim();
      } else {
        whySection =
            explanation.substring(whyIndex + whyIncorrectKey.length).trim();
      }
    } else if (refIndex != -1 && (whyIndex == -1 || refIndex < whyIndex)) {
      beforeWhy = explanation.substring(0, refIndex).trim();
      referencesSection =
          explanation.substring(refIndex + referencesKey.length).trim();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (beforeWhy.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: clickableTextBlock(
              beforeWhy,
              style: TextStyle(
                color: textColor ?? Colors.grey[700],
                fontSize: fontSize,
                height: 1.33,
              ),
            ),
          ),
        if (whySection.isNotEmpty) ...[
          const SizedBox(height: 18),
          Text(
            whyIncorrectKey.replaceAll(':', ''),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: headingFontSize,
              color: headingColor ?? Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          clickableTextBlock(
            whySection,
            style: TextStyle(
              color: textColor ?? Colors.grey[700],
              fontSize: fontSize,
              height: 1.33,
            ),
          ),
        ],
        if (referencesSection.isNotEmpty) ...[
          const SizedBox(height: 18),
          Text(
            referencesKey.replaceAll(':', ''),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: headingFontSize,
              color: headingColor ?? Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          clickableTextBlock(
            referencesSection,
            style: TextStyle(
              color: textColor ?? Colors.grey[700],
              fontSize: fontSize,
              height: 1.33,
            ),
          ),
        ],
      ],
    );
  }
}
