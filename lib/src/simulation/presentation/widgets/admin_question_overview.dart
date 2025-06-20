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

/// Callback signature for notifying parent of content size changes
typedef ContentChanged = void Function({bool scrollToTop});

/// Overview of a single question, with question highlighted when showing answers
class AdminQuestionOverviewWidget extends StatefulWidget {
  final Question question;
  final int questionIndex;
  final ContentChanged onContentChanged;

  const AdminQuestionOverviewWidget({
    Key? key,
    required this.question,
    required this.questionIndex,
    required this.onContentChanged,
  }) : super(key: key);

  @override
  _AdminQuestionOverviewWidgetState createState() =>
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
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    // Wrap entire question in highlight border when answers are shown
    return Container(
      decoration:
          _showAnswer
              ? BoxDecoration(
                color: AppColors.themeTransparent, // highlighted background
                border: Border.all(color: AppColors.themePurple, width: 2),
                borderRadius: BorderRadius.circular(8),
              )
              : null,
      child: BorderBox(
        padding: SpacerUtil.allPadding(SpacerUtil.instance.xxSmall),
        color: AppColors.lightBackground,
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
              // Question Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q.${widget.questionIndex}",
                    style: const TextStyle(
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
              widget.question.questionDescription.isEmpty ||
                      widget.question.questionDescription == ''
                  ? EditorView(
                    initialContent: widget.question.questionDescription,
                  )
                  : SizedBox.shrink(),

              // Options Label
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Options:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              // Options List
              Column(
                children: List.generate(widget.question.options.length, (i) {
                  final isCorrect =
                      widget.question.correctAnswerIndices.contains(i) &&
                      _showAnswer;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 40.h,
                    ), // space between options
                    child: EditorView(
                      initialContent: widget.question.options[i],
                      textColor: isCorrect ? const Color(0xFF4FB152) : null,
                    ),
                  );
                }),
              ),
              SizedBox(height: 5.h),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      await Scrollable.ensureVisible(
                        context,
                        alignment: 0.5,
                        duration: const Duration(milliseconds: 200),
                      );
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
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.orangeColor,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() => _showAnswer = !_showAnswer);
                    },
                    child: Text(
                      !_showAnswer
                          ? AppStrings.showAnswer
                          : AppStrings.hideAnswer,
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.themePurple,
                        fontWeight: FontWeight.bold,
                        color: AppColors.themePurple,
                      ),
                    ),
                  ),
                ],
              ),
              // Correct Answer & Explanation
              if (_showAnswer)
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.lightBackgroundpurple,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          horizontalSpace(2),
                          Text(
                            convertIndicesToLetters(
                              widget.question.correctAnswerIndices,
                            ),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // horizontalSpace(58.w),
                          Spacer(),
                          TextButton(
                            onPressed: () async {
                              await Scrollable.ensureVisible(
                                context,
                                alignment: 0.5,
                                duration: const Duration(milliseconds: 200),
                              );
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
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.orangeColor,
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
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          horizontalSpace(2),
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
                          onPressed: () async {
                            await Scrollable.ensureVisible(
                              context,
                              alignment: 0.5,
                              duration: const Duration(milliseconds: 200),
                            );
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
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.orangeColor,
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
      ),
    );
  }

  /// Convert 0→A, 1→B, etc.
  String convertIndicesToLetters(List<int> indices) =>
      indices.map((i) => String.fromCharCode(65 + i)).join(", ");
}
