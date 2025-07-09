import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmitionDialogue extends StatelessWidget {
  const SubmitionDialogue({super.key, this.taskItem, this.approved});

  final TaskItem? taskItem;
  final bool? approved;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double dialogWidth = width > 600 ? 500 : width * 0.9;

        double padding = width > 600 ? 20 : 12;
        double fontSizeSmall = width > 600 ? 14 : 12;
        double fontSizeMedium = width > 600 ? 15 : 13;
        double fontSizeLarge = width > 600 ? 16 : 14;

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.48.sh,
            maxWidth: dialogWidth,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.purple, width: 2),
            ),
            child: Center(
              child: Container(
                width: dialogWidth,
                padding: EdgeInsets.all(padding),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            AppStrings.submissionText,
                            style: TextStyle(
                              fontSize: fontSizeLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Thank you your report. This help us and our community",
                        style: TextStyle(
                          fontSize: fontSizeSmall,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
