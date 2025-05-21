import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
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
        double width = constraints.maxWidth;
        double dialogWidth = width > 600 ? 500 : width * 0.9;

        double padding = width > 600 ? 20 : 12;
        double fontSizeSmall = width > 600 ? 14 : 12;
        double fontSizeMedium = width > 600 ? 15 : 13;
        double fontSizeLarge = width > 600 ? 16 : 14;

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.90.sh,
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

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
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

                      // Exam Name
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
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
                      ),

                      Divider(color: Colors.black38),
                      SizedBox(height: 4),

                      SizedBox(height: 10),

                      // Description
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'The following question has been marked "Outdated" by other purchasers. Do you approve this request?',
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Question number box
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
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
                      ),

                      SizedBox(height: 10),

                      // Question box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          taskItem?.questionContent ?? "",
                          style: TextStyle(fontSize: fontSizeSmall),
                        ),
                      ),

                      SizedBox(height: 10),

                      // Explanation header
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
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
                      ),

                      SizedBox(height: 8),

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

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
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
                              // Purple border
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ), // Optional: Rounded corners
                              ),
                            ),
                            child: Text(
                              'No, Disapprove',
                              style: TextStyle(
                                fontSize: fontSizeLarge,
                                color:
                                    AppColors
                                        .darkPurple, // Optional: Purple text to match
                              ),
                            ),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ), // Optional: Rounded corners
                              ),
                            ),

                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                    ),
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
                            child: Text(
                              'Yes, Approve',
                              style: TextStyle(fontSize: fontSizeLarge),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 12),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'I Will Skip This One',
                          style: TextStyle(
                            fontSize: fontSizeMedium,
                            decoration: TextDecoration.underline,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
