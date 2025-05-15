import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/shared/widgets/spaces.dart';
import '../bloc/simulation_bloc/simulation_event.dart';
import '../cubit/report_ans_cubit.dart';
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
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            simulationState.simulationData?.fileName ?? "",
                            style: context.textTheme.headlineSmall,
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
                              itemCount:
                                  simulationState.simulationData?.items?.length ??
                                  0,
                              itemBuilder: (context, itemsIndex) {
                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Topic Title : ${simulationState
                                            .simulationData
                                            ?.items?[itemsIndex]
                                            .topic
                                            ?.title ??
                                            ""}"
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            simulationState
                                                .simulationData
                                                ?.items?[itemsIndex]
                                                .topic
                                                ?.topicItems
                                                ?.length ??
                                            0,
                                        itemBuilder: (context, topicItemsIndex) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [

                                              Text("Case Study Title"),
                                              ReadMoreText(
                                                "${simulationState.simulationData?.items?[itemsIndex].topic?.topicItems?[topicItemsIndex].caseStudy?.description}",
                                                trimMode: TrimMode.Line,
                                                trimLines: 5,
                                                colorClickableText:
                                                    AppColors.darkPrimary,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                                moreStyle: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              ListView.builder(
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount:
                                                    simulationState
                                                        .simulationData
                                                        ?.items?[itemsIndex]
                                                        .topic
                                                        ?.topicItems?[topicItemsIndex]
                                                        .caseStudy
                                                        ?.questions
                                                        ?.length ??
                                                    0,
                                                itemBuilder: (context, index) {
                                                  final question =
                                                      simulationState
                                                          .simulationData
                                                          ?.items?[itemsIndex]
                                                          .topic
                                                          ?.topicItems?[topicItemsIndex]
                                                          .caseStudy
                                                          ?.questions?[index];

                                                  return Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Q.${index + 1}",
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight.w500,
                                                              color:
                                                                  AppColors
                                                                      .lightSecondary,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              question?.questionText ??
                                                                  "",
                                                              style:
                                                                  const TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        "      ${question?.questionDescription ?? ""}",
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 16),
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            question
                                                                ?.options
                                                                ?.length ??
                                                            0,
                                                        itemBuilder: (
                                                          context,
                                                          optionIndex,
                                                        ) {
                                                          final isCorrect =
                                                              (question
                                                                      ?.correctAnswerIndices
                                                                      ?.contains(
                                                                        optionIndex,
                                                                      ) ??
                                                                  false) &&
                                                              question?.showAnswer ==
                                                                  true;

                                                          return Text(
                                                            "        ${question?.options?[optionIndex] ?? ""}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  isCorrect
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .black,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.end,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                context: context,
                                                                builder:
                                                                    (
                                                                      context,
                                                                    ) => ReportQuestionDialog(
                                                                      fileId:
                                                                          AppStrings
                                                                              .fileId,
                                                                      questionId:
                                                                          question
                                                                              ?.id ??
                                                                          0,
                                                                    ),
                                                              );
                                                            },
                                                            child: Text(
                                                              AppStrings
                                                                  .reportQue,
                                                              style: TextStyle(
                                                                color:
                                                                    AppColors
                                                                        .orangeColor,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              context
                                                                  .read<
                                                                    SimulationBloc
                                                                  >()
                                                                  .add(
                                                                    ShowAnswerEvent(
                                                                      questionIndex:
                                                                          index,
                                                                    ),
                                                                  );
                                                            },
                                                            child: Text(
                                                              question?.showAnswer ==
                                                                      false
                                                                  ? AppStrings
                                                                      .showAnswer
                                                                  : AppStrings
                                                                      .hideAnswer,
                                                              style: const TextStyle(
                                                                color:
                                                                    AppColors
                                                                        .lightPrimary,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      if (question?.showAnswer ==
                                                          true)
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  8,
                                                                ),
                                                            color: AppColors.grey,
                                                          ),
                                                          padding: EdgeInsets.all(
                                                            10.h,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    AppStrings
                                                                        .correctAnswer,
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          AppColors
                                                                              .black,
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      context
                                                                          .read<
                                                                            ReportAnsCubit
                                                                          >()
                                                                          .reportAnswerAsIncorrect(
                                                                            question,
                                                                          );
                                                                      showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (
                                                                              c,
                                                                            ) => ReportIncorrectAnswerDialog(
                                                                              questionId:
                                                                                  question?.id,
                                                                            ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      '${AppStrings.reportAnswerAsIncorrect}: A',
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        color:
                                                                            AppColors
                                                                                .orangeColor,
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
                                                                          AppStrings
                                                                              .explanation,
                                                                      style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                      ),
                                                                    ),
                                                                    TextSpan(
                                                                      text:
                                                                          "Explanation: ${question?.answerExplanation}",
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(height: 5),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .bottomRight,
                                                                child: TextButton(
                                                                  onPressed: () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (
                                                                            c,
                                                                          ) => ReportExplanationDialogue(
                                                                            questionId:
                                                                                question?.id,
                                                                            fileId:
                                                                                AppStrings.fileId,
                                                                          ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    AppStrings
                                                                        .reportExplanation,
                                                                    style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color:
                                                                          AppColors
                                                                              .orangeColor,
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
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
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
}
