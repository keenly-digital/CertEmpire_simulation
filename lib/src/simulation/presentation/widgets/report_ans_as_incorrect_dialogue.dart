import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_state.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/report_ans_param_model.dart';
import '../../data/models/submit_report_param.dart';

class ReportIncorrectAnswerDialog extends StatelessWidget {
  int? questionId;

  ReportIncorrectAnswerDialog({super.key, this.questionId});

  @override
  Widget build(BuildContext context) {
    TextEditingController explanationController = TextEditingController();
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red, width: 1.5.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      insetPadding: EdgeInsets.all(16.w),
      child: SizedBox(
        height: ScreenUtil().screenHeight * 0.97,
        width: ScreenUtil().screenWidth * 0.75,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: BlocBuilder<ReportAnsCubit, ReportAnswerState>(
            builder: (context, reportAndQuestionState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "Report Answer As Incorrect",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Choose The Option That You Believe Is Right One:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        reportAndQuestionState.question?.options?.length ?? 0,
                    itemBuilder: (context, index) {
                      final optionText =
                          reportAndQuestionState.question?.options?[index] ??
                          "";
                      final isSelected = reportAndQuestionState
                          .selectedOptionIndices
                          .contains(index);

                      return GestureDetector(
                        onTap: () {
                          context.read<ReportAnsCubit>().toggleOptionSelection(
                            index,
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: Text(
                            optionText,
                            style: TextStyle(
                              color: isSelected ? Colors.green : Colors.black,
                              fontSize: 9.sp,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Why Do You Think That Your Suggestion Is Right\nAnd Our Selected Answer Was Wrong?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 9.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Write An Explanation To This Selection.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: explanationController,
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: SizedBox(
                      width: 150.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: BorderSide(color: Colors.red, width: 1.5.w),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () async {
                          if (explanationController.text.isEmpty) {
                            CommonHelper.showToast(
                              message: "Please provide an explanation",
                            );
                            return;
                          } else if (reportAndQuestionState
                              .selectedOptionIndices
                              .isEmpty) {
                            CommonHelper.showToast(
                              message: "Select an option from Answers",
                            );

                            return;
                          }
                          ReportAnsParamsModel
                          reportAnsParamsModel = ReportAnsParamsModel(
                            submitQuestionReportParam:
                                SubmitQuestionReportParam(
                                  explanation: explanationController.text,
                                  type: ReportTypeEnum.Answer.index,
                                  userId:
                                      AppStrings.userId,
                                  targetId: questionId ?? 0,
                                  reason: "",
                                  fileId: AppStrings.fileId,
                                ),
                          );
                          await context.read<ReportAnsCubit>().submitReport(
                            reportAnsParamsModel,
                            context,
                          );

                          Navigator.of(
                            context,
                          ).pop(); // You can trigger any action here
                        },
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
