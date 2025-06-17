import 'package:certempiree/src/simulation/presentation/views/editor/editor_view.dart';
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
import '../cubit/report_ans_cubit.dart';
import 'border_box.dart';

/// Overview of a single question, allows toggling answer/explanation display
class AdminQuestionOverviewWidget extends StatefulWidget {
  final Question question;
  final int questionIndex;
  final VoidCallback
  onContentChanged; // callback to notify parent of size change

  const AdminQuestionOverviewWidget({
    Key? key,
    required this.question,
    required this.questionIndex,
    required this.onContentChanged,
  }) : super(key: key);

  @override
  State<AdminQuestionOverviewWidget> createState() =>
      _AdminQuestionOverviewWidgetState();
}

class _AdminQuestionOverviewWidgetState
    extends State<AdminQuestionOverviewWidget> {
  bool _showAnswer = false;

  double calculateLeftMargin() {
    if (widget.question.hasTopic() && widget.question.hasCaseStudy()) {
      return SpacerUtil.instance.large;
    } else if (widget.question.hasTopic() || widget.question.hasCaseStudy()) {
      return SpacerUtil.instance.medium;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      padding: SpacerUtil.allPadding(SpacerUtil.instance.xxSmall),
      margin: SpacerUtil.only(
        top: SpacerUtil.instance.small,
        left: calculateLeftMargin(),
        bottom: SpacerUtil.instance.small,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Q.${widget.questionIndex}",
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: EditorView(
                    initialContent: widget.question.questionText,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            EditorView(initialContent: widget.question.questionDescription),
            const SizedBox(height: 16),
            // Options list
            Column(
              children: List.generate(widget.question.options.length, (i) {
                final isCorrect =
                    widget.question.correctAnswerIndices.contains(i) &&
                    _showAnswer;
                return EditorView(
                  initialContent: widget.question.options[i],
                  textColor: isCorrect ? Colors.green : null,
                );
              }),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.transparent,
                      context: context,
                      builder:
                          (_) => ReportQuestionDialog(
                            fileId: AppStrings.fileId,
                            questionId: widget.question.id,
                            questionIndex: widget.questionIndex,
                          ),
                    );
                  },
                  child: Text(
                    AppStrings.reportQue,
                    style: TextStyle(color: AppColors.reportColor),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() => _showAnswer = !_showAnswer);
                    widget.onContentChanged(); // notify parent to re-measure
                  },
                  child: Text(
                    !_showAnswer
                        ? AppStrings.showAnswer
                        : AppStrings.hideAnswer,
                    style: const TextStyle(color: AppColors.lightPurple),
                  ),
                ),
              ],
            ),
            if (_showAnswer)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
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
                          convertIndicesToLetters(
                            widget.question.correctAnswerIndices,
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            context
                                .read<ReportAnsCubit>()
                                .reportAnswerAsIncorrect(widget.question);
                            showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder:
                                  (_) => ReportIncorrectAnswerDialog(
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.explanation,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        horizontalSpace(3),
                        Expanded(
                          child: EditorView(
                            initialContent: widget.question.answerExplanation,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            barrierColor: Colors.transparent,
                            context: context,
                            builder:
                                (_) => ReportExplanationDialogue(
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
      ),
    );
  }

  String convertIndicesToLetters(List<int> indices) =>
      indices.map((i) => String.fromCharCode(65 + i)).join(", ");
}
