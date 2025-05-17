import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

class BorderBox extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final Color borderColor;
  final BorderRadius? borderRadius;
  final bool showBorder; // Toggle for border
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxShape shape; // Circular or rectangular
  const BorderBox({
    super.key,
    this.width,
    this.height,
    this.color = AppColors.lightBackground,
    this.borderColor = Colors.grey,
    this.borderRadius,
    this.child,
    this.padding,
    this.margin,
    this.shape = BoxShape.rectangle,
    this.showBorder = false, // Default is no border
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        color: color,
        border: showBorder
            ? Border.all(
          color: borderColor,
          width: 1,
        )
            : null, // Apply border if showBorder is true
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
