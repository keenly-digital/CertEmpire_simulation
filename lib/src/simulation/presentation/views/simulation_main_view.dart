import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/answer_option_widget.dart';
import '../widgets/report_ans_as_incorrect_dialogue.dart';
import '../widgets/report_explaination_as_incorrect_dialogue.dart';
import '../widgets/report_question_dialogue.dart';

class ExamQuestionPage extends StatelessWidget {
  const ExamQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AWS Certified Advanced Networking - Specialty ANS-C01',
          style: TextStyle(color: AppColors.darkBlue),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                labelText: 'Search',
                hintStyle: TextStyle(color: Colors.black),
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Q.${index + 1}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.lightSecondary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'A company is planning to create a service that requires encryption in transit...',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "       Which solution will meet these requirements?",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const AnswerOption(
                        label: 'A.',
                        text:
                            'Install the AWS Load Balancer Controller for Kubernetes. Using that controller, configure a Network Load Balancer with a TCP listener on port 443 to forward traffic to the IP addresses of the backend service Pods.',
                      ),
                      const AnswerOption(
                        label: 'B.',
                        text:
                            'Install the AWS Load Balancer Controller for Kubernetes. Using that controller, configure a Network Load Balancer with a TCP listener on port 443 to forward traffic to the IP addresses of the backend service Pods.',
                      ),
                      const AnswerOption(
                        label: 'C.',
                        text: 'Create a target group...',
                      ),
                      const AnswerOption(
                        label: 'D.',
                        text: 'Create a target group...',
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => ReportExplainationDialogue(),
                              );
                            },
                            child: Text(
                              AppStrings.reportQue,
                              style: TextStyle(color: AppColors.orangeColor),
                            ),
                          ),
                          const SizedBox(width: 8),

                          TextButton(
                            onPressed: () {
                              // Handle show answer
                            },
                            child: const Text(
                              AppStrings.showAnswer,
                              style: TextStyle(color: AppColors.lightPrimary),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.grey,
                        ),
                        padding: EdgeInsets.all(10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppStrings.correctAnswer,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (c) => ReportIncorrectAnswerDialog(),
                                    );
                                  },
                                  child: Text(
                                    '${AppStrings.reportAnswerAsIncorrect}: A',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.orangeColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppStrings.explanation,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "Explanation Option 1 is the best solution because it enables reliable and direct communication between the two data centers using the existing transit VIFs and Direct Connect infrastructure. This approach minimizes changes, reduces complexity, and improves the reliability of the connection. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                  ),
                                ],
                              ),
                            ),
                            // Row(crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       "Explanation",
                            //       style: TextStyle(fontWeight: FontWeight.w700),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         'Explanation Option 1 is the best solution because it enables reliable and direct communication between the two data centers using the existing transit VIFs and Direct Connect infrastructure. This approach minimizes changes, reduces complexity, and improves the reliability of the connection. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 5),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (c) => ReportExplainationDialogue(),
                                  );
                                },
                                child: Text(
                                  AppStrings.reportExplanation,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.orangeColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
