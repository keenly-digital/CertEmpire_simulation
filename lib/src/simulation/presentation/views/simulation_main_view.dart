import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/simulation_bloc/simulation_event.dart';
import '../widgets/app_button.dart';
import '../widgets/report_ans_as_incorrect_dialogue.dart';
import '../widgets/report_explaination_as_incorrect_dialogue.dart';
import '../widgets/report_question_dialogue.dart';

class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({super.key});

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (!mounted) return;
      context.read<SimulationBloc>().add(
        FetchSimulationDataEvent(fieldId: AppStrings.fileId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulationBloc, SimulationInitState>(
      builder: (context, simulationState) {
        var simulationData = simulationState as SimulationState;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                simulationData.loading == true
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          simulationData.simulationData?.examTitle ?? "",
                          style: TextStyle(
                            color: AppColors.darkBlue,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.w,
                                  ),
                                  labelText: 'Search',
                                  hintStyle: TextStyle(color: Colors.black),
                                  labelStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                            horizontalSpace(5),
                            appButton(
                              onPressed: () {},
                              text: "Save In Account",
                              textColor: Colors.black,
                            ),
                            horizontalSpace(5),
                            appButton(
                              withIcon: true,
                              onPressed: () {},
                              text: "Save In Account",
                              textColor: Colors.white,
                              borderColor: AppColors.darkPrimary,
                              background: AppColors.darkPrimary,
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16.0),
                            itemCount:
                                simulationData
                                    .simulationData
                                    ?.questions
                                    ?.length ??
                                0,
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
                                          simulationData
                                                  .simulationData
                                                  ?.questions?[index]
                                                  .questionText ??
                                              "",
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
                                    "      ${simulationData.simulationData?.questions?[index].questionDescription ?? ""}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  ListView.builder(
                                    itemBuilder: (context, optionIndex) {
                                      final question =
                                          simulationData
                                              .simulationData
                                              ?.questions?[index];
                                      final isCorrect =
                                          (question?.correctAnswerIndices
                                                  ?.contains(optionIndex) ??
                                              false) &&
                                          question?.showAnswer == true;

                                      return Text(
                                        "        ${question?.options?[optionIndex] ?? ""}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              isCorrect
                                                  ? Colors.green
                                                  : Colors
                                                      .black, // Green if correct
                                        ),
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount:
                                        simulationData
                                            .simulationData
                                            ?.questions?[index]
                                            .options
                                            ?.length ??
                                        0,
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (
                                                  context,
                                                ) => ReportQuestionDialog(
                                                  fileId: AppStrings.fileId,
                                                  questionId:
                                                      simulationData
                                                          .simulationData
                                                          ?.questions?[index]
                                                          .id,
                                                ),
                                          );
                                        },
                                        child: Text(
                                          AppStrings.reportQue,
                                          style: TextStyle(
                                            color: AppColors.orangeColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),

                                      TextButton(
                                        onPressed: () {
                                          context.read<SimulationBloc>().add(
                                            ShowAnswerEvent(
                                              questionIndex: index,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          simulationData
                                                      .simulationData
                                                      ?.questions?[index]
                                                      .showAnswer ==
                                                  false
                                              ? AppStrings.showAnswer
                                              : AppStrings.hideAnswer,
                                          style: const TextStyle(
                                            color: AppColors.lightPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  simulationData
                                              .simulationData
                                              ?.questions?[index]
                                              .showAnswer ==
                                          true
                                      ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          color: AppColors.grey,
                                        ),
                                        padding: EdgeInsets.all(10.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                    context
                                                        .read<ReportAnsCubit>()
                                                        .reportAnswerAsIncorrect(
                                                          simulationData
                                                              .simulationData
                                                              ?.questions?[index],
                                                        );
                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (
                                                            c,
                                                          ) => ReportIncorrectAnswerDialog(
                                                            questionId:
                                                                simulationData
                                                                    .simulationData
                                                                    ?.questions?[index]
                                                                    .id,
                                                          ),
                                                    );
                                                  },
                                                  child: Text(
                                                    '${AppStrings.reportAnswerAsIncorrect}: A',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          AppColors.orangeColor,
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
                                                    text:
                                                        AppStrings.explanation,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "Explanation: ${simulationData.simulationData?.questions?[index].explanation}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5),

                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                onPressed: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (
                                                          c,
                                                        ) => ReportExplanationDialogue(
                                                          questionId:
                                                              simulationData
                                                                  .simulationData
                                                                  ?.questions?[index]
                                                                  .id,
                                                          fileId:
                                                              AppStrings.fileId,
                                                        ),
                                                  );
                                                },
                                                child: Text(
                                                  AppStrings.reportExplanation,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.orangeColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      : Container(),
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
      },
    );
  }
}
