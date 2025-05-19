import 'package:flutter_quill/quill_delta.dart';

/// @Author: Ehsan
/// @Email: muhammad.ehsan@barq.com.pk
/// @Date: 17/05/2025

/// Converts input string with embedded image tags to Delta JSON
List<dynamic> parseStringToDeltaJson(String input) {
  final delta = Delta();

  // Regex to match <img src='...'> tags, direct image URLs, and reference URLs
  final regex = RegExp(
    r"<img\s+src='(.*?)'>|https?:\/\/\S+\.(jpg|png)|https?:\/\/\S+",
    caseSensitive: false,
  );

  int lastIndex = 0;

  // Iterate over all matches
  for (final match in regex.allMatches(input)) {
    // Add plain text before the match
    if (match.start > lastIndex) {
      delta.insert(input.substring(lastIndex, match.start));
    }

    String? matchedUrl;
    String? embedType;

    // Check for an <img src='...'> tag
    if (match.group(1) != null) {
      matchedUrl = match.group(1); // Extract URL
      embedType = "image";
    }
    // Check for a direct image URL
    else if (RegExp(r"https?:\/\/\S+\.(jpg|png)", caseSensitive: false).hasMatch(match.group(0)!)) {
      matchedUrl = match.group(0); // Use the entire match as the URL
      embedType = "image";
    }
    // Check for a reference URL
    else {
      matchedUrl = match.group(0); // Use the entire match as the URL
      embedType = "link";
    }

    // Handle image embeds
    if (embedType == "image" && matchedUrl != null) {
      delta.insert({"image": matchedUrl});
      delta.insert("\n"); // Add newline after the image
    }

    // Handle reference links
    if (embedType == "link" && matchedUrl != null) {
      delta.insert(
        matchedUrl,
        {"link": matchedUrl}, // Embed the link
      );
      delta.insert("\n"); // Add newline after the link
    }

    lastIndex = match.end;
  }

  // Add remaining text after the last match
  if (lastIndex < input.length) {
    delta.insert(input.substring(lastIndex));
  }

  // Ensure the document ends with a newline
  if (!input.endsWith('\n')) {
    delta.insert("\n");
  }

  return delta.toJson();
}

/// Converts Delta JSON back to a plain string with embedded image tags, URLs, etc.

/// Converts Delta JSON back to a plain string with embedded image tags, URLs, etc.
String deltaToPlainString(List<Map<String, dynamic>>? deltaJson) {
  final buffer = StringBuffer();

  if (deltaJson == null) {
    return '';
  }

  for (final op in deltaJson) {
    final insert = op['insert'];

    if (insert is String) {
      // Check for embedded attributes (e.g., links)
      final attributes = op['attributes'] as Map<String, dynamic>?;
      if (attributes != null && attributes.containsKey('link')) {
        final link = attributes['link'];
        buffer.write(link); // Append the raw link
      } else {
        buffer.write(insert); // Append plain text
      }
    } else if (insert is Map<String, dynamic>) {
      if (insert.containsKey('image')) {
        final imageUrl = insert['image'];
        buffer.write("<img src='$imageUrl'>");
      }
    }
  }

  return buffer.toString();
}
