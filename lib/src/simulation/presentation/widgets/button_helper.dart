
import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

class TextButtonHelper extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const TextButtonHelper({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle ??
            context.textTheme.labelLarge!
                .copyWith(color: AppColors.lightPrimary),
      ),
    );
  }
}