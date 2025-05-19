
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../../../core/utils/spacer_utility.dart';
import '../../widgets/border_box.dart';


class CustomToolbar extends StatelessWidget {
  const CustomToolbar({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      color: AppColors.grey,
      margin: SpacerUtil.only(bottom: SpacerUtil.instance.small),
      child: Row(
        children: [
          QuillToolbarHistoryButton(
            isUndo: true,
            controller: controller,
          ),
          QuillToolbarHistoryButton(
            isUndo: false,
            controller: controller,
          ),
          QuillToolbarToggleStyleButton(
            options: const QuillToolbarToggleStyleButtonOptions(),
            controller: controller,
            attribute: Attribute.bold,
          ),
          QuillToolbarToggleStyleButton(
            options: const QuillToolbarToggleStyleButtonOptions(),
            controller: controller,
            attribute: Attribute.italic,
          ),
          QuillToolbarToggleStyleButton(
            controller: controller,
            attribute: Attribute.underline,
          ),
          QuillToolbarClearFormatButton(
            controller: controller,
          ),
          QuillToolbarImageButton(
            controller: controller,
          ),
          QuillToolbarLinkStyleButton(controller: controller),
        ],
      ),
    );
  }
}