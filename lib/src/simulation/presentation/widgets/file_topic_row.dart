import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/asset.dart';
import '../../data/models/file_content_model.dart';

class FileTopicRowWidget extends StatelessWidget {
  final Topic topic;

  const FileTopicRowWidget({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    // This is the simple, integrated layout from your screenshot
    return Padding(
      // Padding to give it space, but no card background
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // The folder icon
          Image.asset(
            Assets.topic, 
            width: 28,
            height: 28,
            color: Colors.black.withOpacity(0.7),
          ),
          const SizedBox(width: 16),
          // Column for the title and subtitle
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Use RichText to add the "Topic: " label
                RichText(
                  text: TextSpan(
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [
                      const TextSpan(
                        text: "Topic: ",
                        style: TextStyle(fontWeight: FontWeight.w500) // Slightly less bold label
                      ),
                      TextSpan(text: topic.title),
                    ],
                  ),
                ),
                if (topic.getCaseStudyCount() > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    "Case Studies: ${topic.getCaseStudyCount()}",
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: Colors.grey.shade600),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
