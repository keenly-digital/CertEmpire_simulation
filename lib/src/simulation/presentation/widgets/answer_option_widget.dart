import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String label;
  final String text;

  const AnswerOption({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        label,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16,),
      ),
      title: Text(text, style: context.textTheme.titleSmall),
    );
  }
}
