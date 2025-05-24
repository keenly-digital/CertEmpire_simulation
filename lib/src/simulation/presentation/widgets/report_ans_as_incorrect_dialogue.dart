import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_state.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/report_ans_param_model.dart';
import '../../data/models/submit_report_param.dart';

class ReportIncorrectAnswerDialog extends StatelessWidget {
  final int? questionId;

  const ReportIncorrectAnswerDialog({super.key, this.questionId});

  @override
  Widget build(BuildContext context) {
    TextEditingController explanationController = TextEditingController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;
        final dialogHeight = screenHeight * 0.95;

        return Dialog(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          insetPadding: const EdgeInsets.all(16),
          child: SizedBox(
            width: dialogWidth,
            height: dialogHeight,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
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
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Choose The Option That You Believe Is Right One:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                        reportAndQuestionState.question?.options?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final optionText = reportAndQuestionState
                              .question?.options?[index] ??
                              "";
                          final isSelected = reportAndQuestionState
                              .selectedOptionIndices
                              .contains(index);

                          return GestureDetector(
                            onTap: () {
                              context
                                  .read<ReportAnsCubit>()
                                  .toggleOptionSelection(index);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                optionText,
                                style: TextStyle(
                                  color:
                                  isSelected ? Colors.green : Colors.black,
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Why Do You Think That Your Suggestion Is Right\nAnd Our Selected Answer Was Wrong?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Write An Explanation To This Selection.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: explanationController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintStyle:
                          const TextStyle(fontSize: 13, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: SizedBox(
                          width: dialogWidth * 0.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side:
                              const BorderSide(color: Colors.red, width: 1.5),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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

                              ReportAnsParamsModel reportAnsParamsModel =
                              ReportAnsParamsModel(
                                submitQuestionReportParam:
                                SubmitQuestionReportParam(
                                  explanation: explanationController.text,
                                  type: ReportTypeEnum.Answer.index,
                                  userId: AppStrings.userId,
                                  targetId: questionId ?? 0,
                                  reason: "",
                                  fileId: AppStrings.fileId,
                                ),
                              );

                              await context
                                  .read<ReportAnsCubit>()
                                  .submitReport(reportAnsParamsModel, context);

                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "SUBMIT",
                              style: TextStyle(fontSize: 15),
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
      },
    );
  }
}
