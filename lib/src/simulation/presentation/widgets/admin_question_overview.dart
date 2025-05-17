import 'package:certempiree/src/simulation/presentation/widgets/report_ans_as_incorrect_dialogue.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_explaination_as_incorrect_dialogue.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_question_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/res/app_strings.dart';
import '../../../../core/shared/widgets/spaces.dart';
import '../../../../core/utils/spacer_utility.dart';
import '../../data/models/question_model.dart';
import '../bloc/simulation_bloc/simulation_bloc.dart';
import '../bloc/simulation_bloc/simulation_event.dart';
import '../cubit/report_ans_cubit.dart';
import 'border_box.dart';

class AdminQuestionOverviewWidget extends StatefulWidget {
  final Question question;
  final int questionIndex;
  final VoidCallback? onShowAnswerToggle; // Callback for answer toggle

  const AdminQuestionOverviewWidget({
    super.key,
    required this.question,
    required this.questionIndex,
    this.onShowAnswerToggle,
  });

  @override
  State<AdminQuestionOverviewWidget> createState() =>
      _AdminQuestionOverviewWidgetState();
}

class _AdminQuestionOverviewWidgetState
    extends State<AdminQuestionOverviewWidget> {
  bool _showAnswer = false;

  @override
  void initState() {
    super.initState();
    // _showAnswer = widget.question.showAnswer;
  }

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      margin: SpacerUtil.only(bottom: SpacerUtil.instance.small),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Q.${widget.questionIndex}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightSecondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.question.questionText ?? "",
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
                  "      ${widget.question.questionDescription ?? ""}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.question.options.length,
                  itemBuilder: (context, optionIndex) {
                    final isCorrect =
                        (widget.question.correctAnswerIndices.contains(
                          optionIndex,
                        )) &&
                        _showAnswer == true;

                    return Text(
                      "        ${widget.question.options[optionIndex] ?? ""}",
                      style: TextStyle(
                        fontSize: 16,
                        color: isCorrect ? Colors.green : Colors.black,
                      ),
                    );
                  },
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
                              (context) => ReportQuestionDialog(
                                fileId: AppStrings.fileId,
                                questionId: widget.question.id ?? 0,
                              ),
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
                        setState(() {
                          _showAnswer = !_showAnswer;
                          print(_showAnswer);
                          print("sadjiwejioewjfuheruvfvbxnv");
                        });
                        context.read<SimulationBloc>().add(
                          ShowAnswerEvent(questionIndex: widget.questionIndex),
                        );
                      },
                      child: Text(
                        !_showAnswer
                            ? AppStrings.showAnswer
                            : AppStrings.hideAnswer,
                        style: const TextStyle(color: AppColors.lightPrimary),
                      ),
                    ),
                  ],
                ),
                if (_showAnswer == true)
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
                          children: [
                            Text(
                              AppStrings.correctAnswer,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            horizontalSpace(5.w),
                            Text(
                              widget.question.correctAnswerIndices.join(", "),

                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.black,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<ReportAnsCubit>()
                                    .reportAnswerAsIncorrect(widget.question);
                                showDialog(
                                  context: context,
                                  builder:
                                      (c) => ReportIncorrectAnswerDialog(
                                        questionId: widget.question.id,
                                      ),
                                );
                              },
                              child: Text(
                                AppStrings.reportAnswerAsIncorrect,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orangeColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.explanation,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(text: widget.question.answerExplanation),
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
                                    (c) => ReportExplanationDialogue(
                                      questionId: widget.question.id,
                                      fileId: AppStrings.fileId,
                                    ),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
