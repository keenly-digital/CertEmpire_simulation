import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/presentation/widgets/question_explanation_task.dart';
import 'package:certempiree/src/simulation/presentation/views/editor/editor_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/asset.dart';

class ExplanationReportTask extends StatelessWidget {
  const ExplanationReportTask({super.key, this.taskItem});

  final TaskItem? taskItem;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The breakpoint is set to 600px for consistency.
        final bool isWide = constraints.maxWidth > 600;

        return Center(
          child: Container(
            // On narrow screens, reduce horizontal padding to give content more space
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: isWide ? 16 : 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.purple),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Using Flexible prevents long titles from causing an overflow.
                      Flexible(
                        child: Text(
                          taskItem?.reportType != "Answer"
                              ? 'Incorrect Explanation'
                              : 'Incorrect Answer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      horizontalSpace(16),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(Assets.cross, height: 20, width: 20),
                      ),
                    ],
                  ),
                  Divider(color: AppColors.purple),
                  verticalSpace(12),

                  /// Exam Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Exam Name :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      horizontalSpace(5),
                      Expanded(
                        child: Text(
                          taskItem?.examName?.replaceAll("%", "") ?? "",
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(12),

                  /// Question Card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.optionBackground,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Using Flexible here as well for robustness.
                            Flexible(
                              child: Text(
                                taskItem?.questionNumber ?? 'Question',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            horizontalSpace(8),
                            InkWell(
                              onTap: () {}, // Business logic is untouched
                              child: Text(
                                'View on File',
                                style: TextStyle(
                                  color: AppColors.purple,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(8),
                        EditorView(
                          initialContent: taskItem?.questionContent ?? "",
                        ),
                      ],
                    ),
                  ),

                  verticalSpace(10),

                  /// Current Answer + Explanation
                  Container(
                    color: AppColors.optionBackground,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(5),
                        Text(
                          'Current Answer:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.purple,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.purple,
                          ),
                        ),
                        verticalSpace(6),
                        ListView.builder(
                          itemCount: taskItem?.options?.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Text(
                              taskItem?.options?[index] ?? "",
                              style: TextStyle(color: AppColors.green),
                            );
                          },
                        ),
                        verticalSpace(16),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                          ),
                          child: Text(
                            'Current Explanation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        verticalSpace(6),
                        EditorView(
                          initialContent: taskItem?.currentExplanation ?? "",
                        ),
                      ],
                    ),
                  ),

                  /// Suggested Explanation
                  Container(
                    width: 1.sw,
                    color: AppColors.optionBackground,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(16),
                        Text(
                          'Suggested Explanation:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.purple,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.purple,
                          ),
                        ),
                        verticalSpace(6),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.black),
                          ),
                          child: Text(
                            'Explanation',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        verticalSpace(6),
                        Text(taskItem?.suggestedExplanation ?? ""),
                        verticalSpace(20),
                      ],
                    ),
                  ),

                  verticalSpace(10),

                  /// --- RESPONSIVE ACTION BUTTONS ---

                  _buildActionButtons(context, isWide),

                  verticalSpace(12),

                  Center(
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        'I Will Skip This One',
                        style: TextStyle(
                          color: AppColors.purple,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the action buttons adaptively.
  /// Returns a [Row] for wide screens and a [Column] for narrow screens.
  Widget _buildActionButtons(BuildContext context, bool isWide) {
    // Define the "Disapprove" button to avoid repetition.
    // The onPressed logic is preserved exactly.
    final disapproveButton = OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
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
        side: BorderSide(color: AppColors.purple),
        foregroundColor: AppColors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text('No, Disapprove'),
    );

    // Define the "Approve" button.
    final approveButton = OutlinedButton(
      onPressed: () {
        Navigator.pop(context);

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
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.purple),
        backgroundColor: AppColors.purple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text('Yes, Approve'),
    );

    // If the screen is wide, return a Row.
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [disapproveButton, approveButton],
      );
    }

    // Otherwise, return a Column for narrow screens.
    // CrossAxisAlignment.stretch makes the buttons fill the width.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        approveButton, // Primary action first
        verticalSpace(8),
        disapproveButton,
      ],
    );
  }
}
