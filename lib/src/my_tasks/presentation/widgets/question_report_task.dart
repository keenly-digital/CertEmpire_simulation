import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/simulation/presentation/views/editor/editor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'question_explanation_task.dart';

class QuestionReportTask extends StatelessWidget {
  const QuestionReportTask({super.key, this.taskItem});

  final TaskItem? taskItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- Responsive Sizing ---
        // This approach to responsive sizing is preserved.
        final bool isWide = constraints.maxWidth > 600;
        final double padding = isWide ? 20 : 16;
        final double fontSizeSmall = isWide ? 14 : 12;
        final double fontSizeMedium = isWide ? 15 : 13;
        final double fontSizeLarge = isWide ? 16 : 14;

        return ConstrainedBox(
          // Let the dialog manage the width, just constrain the height.
          constraints: BoxConstraints(maxHeight: 0.90.sh),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.purple, width: 2),
            ),
            child: Container(
              padding: EdgeInsets.all(padding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            taskItem?.reason ?? "",
                            style: TextStyle(
                              fontSize: fontSizeLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            Assets.cross,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: AppColors.purple),
                    SizedBox(height: 10),

                    // --- Exam Name ---
                    Row(
                      children: [
                        Text(
                          "Exam Name : ",
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            taskItem?.examName?.replaceAll("%", "") ?? "",
                            style: TextStyle(
                              fontSize: fontSizeSmall,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: Colors.black38),
                    SizedBox(height: 10),

                    // --- Description ---
                    Text(
                      'The following question has been marked "Outdated" by other purchasers. Do you approve this request?',
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),

                    // --- Question Number Box ---
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Question ${taskItem?.questionNumber ?? ""}",
                        style: TextStyle(
                          fontSize: fontSizeSmall,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    // --- Question Box ---
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: EditorView(
                        initialContent: taskItem?.questionContent ?? "",
                      ),
                    ),
                    SizedBox(height: 10),

                    // --- Explanation Header ---
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Explanation Provided',
                        style: TextStyle(
                          fontSize: fontSizeSmall,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    // --- Explanation Content ---
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        taskItem?.suggestedExplanation ?? "",
                        style: TextStyle(fontSize: fontSizeMedium),
                      ),
                    ),
                    SizedBox(height: 20),

                    // --- RESPONSIVE ACTION BUTTONS ---
                    // This new method builds a Row or Column based on screen width.
                    _buildActionButtons(context, isWide, fontSizeLarge),

                    SizedBox(height: 12),

                    // --- Skip Button ---
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'I Will Skip This One',
                          style: TextStyle(
                            fontSize: fontSizeMedium,
                            decoration: TextDecoration.underline,
                            color: Colors.deepPurple,
                          ),
                        ),
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

  /// Builds the action buttons adaptively.
  /// Returns a [Row] for wide screens and a [Column] for narrow screens.
  Widget _buildActionButtons(
    BuildContext context,
    bool isWide,
    double fontSize,
  ) {
    // Define the "Disapprove" button to avoid repetition.
    // The onPressed logic is preserved exactly.
    final disapproveButton = OutlinedButton(
      onPressed: () {
        showDialog(
          barrierColor: Colors.transparent,
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: QuestionExplanationTask(
                taskItem: taskItem,
                approved: false,
              ),
            );
          },
        );
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        'No, Disapprove',
        style: TextStyle(fontSize: fontSize, color: AppColors.darkPurple),
      ),
    );

    // Define the "Approve" button.
    final approveButton = ElevatedButton(
      onPressed: () {
        showDialog(
          barrierColor: Colors.transparent,
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 10.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: QuestionExplanationTask(
                taskItem: taskItem,
                approved: true,
              ),
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        'Yes, Approve',
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    );

    // If the screen is wide, return a Row.
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [disapproveButton, approveButton],
      );
    }

    // Otherwise, return a Column for narrow screens.
    // CrossAxisAlignment.stretch makes the buttons fill the width.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        approveButton, // Primary action first
        SizedBox(height: 8),
        disapproveButton,
      ],
    );
  }
}
