import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart';

class NavItemView extends StatelessWidget {
  final String label; // Text label for the nav item
  final bool isSelected; // Whether the item is selected
  final VoidCallback onTap; // Callback for when the item is clicked
  final double iconSize; // Size of the icon
  const NavItemView({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.iconSize = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.selectedBackground
                  : Colors.transparent, // Rounded for selected state
        ),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style:
                  isSelected
                      ? context.textTheme.labelMedium!.copyWith(
                        color: AppColors.black,
                      )
                      : context.textTheme.labelMedium!.copyWith(
                        color: AppColors.purple,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
