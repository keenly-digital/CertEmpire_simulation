import 'package:certempiree/src/simulation/presentation/widgets/report_ans_as_incorrect_dialogue.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_explaination_as_incorrect_dialogue.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_question_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/res/app_strings.dart';
import '../../data/models/question_model.dart';
import '../cubit/report_ans_cubit.dart';

// Helper for inline images, as it was in your stable version
List<_DescPart> splitTextAndImages(String input) {
  final RegExp imgExp = RegExp(
    r'(https?:\/\/\S+\.(?:png|jpg|jpeg|gif|webp))',
    caseSensitive: false,
  );
  final matches = imgExp.allMatches(input);
  int last = 0;
  List<_DescPart> parts = [];
  for (final match in matches) {
    if (match.start > last) {
      parts.add(_DescPart.text(input.substring(last, match.start)));
    }
    parts.add(_DescPart.image(match.group(0)!));
    last = match.end;
  }
  if (last < input.length) {
    parts.add(_DescPart.text(input.substring(last)));
  }
  return parts;
}

class _DescPart {
  final String? text;
  final String? imageUrl;
  _DescPart.text(this.text) : imageUrl = null;
  _DescPart.image(this.imageUrl) : text = null;
  bool get isImage => imageUrl != null;
}

Widget inlineTextWithImages(
  String input, {
  TextStyle? style,
  double? imageMaxWidth,
}) {
  final parts = splitTextAndImages(input);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
        parts.map((part) {
          if (part.isImage) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  part.imageUrl!,
                  fit: BoxFit.contain,
                  width: imageMaxWidth,
                  loadingBuilder:
                      (context, child, progress) =>
                          progress == null
                              ? child
                              : const SizedBox(
                                height: 36,
                                width: 36,
                                child: CircularProgressIndicator(),
                              ),
                  errorBuilder:
                      (context, error, stackTrace) => Text(
                        '[Image failed to load]',
                        style: TextStyle(color: Colors.red),
                      ),
                ),
              ),
            );
          } else {
            final txt = part.text!.trim();
            if (txt.isEmpty) return const SizedBox.shrink();
            return Text(
              txt,
              style:
                  style ??
                  const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.33,
                  ),
            );
          }
        }).toList(),
  );
}

typedef ContentChanged = void Function({bool scrollToTop});

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

  @override
  void didUpdateWidget(covariant AdminQuestionOverviewWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.question.id != oldWidget.question.id) {
      setState(() {
        _showAnswer = false;
      });
    }
  }

  Widget _buildReportButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16.0),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.orangeColor,
        side: BorderSide(color: AppColors.orangeColor.withOpacity(0.5)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required VoidCallback onPressed,
    required String text,
    required IconData icon,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16.0),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.themePurple,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.grey.shade500,
        fontWeight: FontWeight.w600,
        fontSize: 12,
        letterSpacing: 0.8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasCorrectAnswer =
        widget.question.correctAnswerIndices.isNotEmpty;
    final bool hasExplanation = widget.question.answerExplanation.isNotEmpty;

    // --- The beautiful card container is restored here ---
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _showAnswer
                ? AppColors.lightBackgroundpurple.withOpacity(0.15)
                : Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.6],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.themePurple.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        // The original Padding widget is now inside
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.themePurple.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Q${widget.questionIndex}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.themePurple,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: inlineTextWithImages(
                    widget.question.questionText,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      height: 1.34,
                      letterSpacing: 0.01,
                    ),
                    imageMaxWidth: 400,
                  ),
                ),
              ],
            ),
            if (widget.question.questionDescription.isNotEmpty) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 58),
                child: inlineTextWithImages(
                  widget.question.questionDescription,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                    height: 1.33,
                  ),
                  imageMaxWidth: 350,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(left: 58),
              child: _buildLabel("Options"),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 58.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(widget.question.options.length, (i) {
                  final isCorrect =
                      widget.question.correctAnswerIndices.contains(i) &&
                      _showAnswer;
                  final String optionLetter = String.fromCharCode(65 + i);
                  final String optionText = widget.question.options[i] ?? '';

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 140),
                    margin: const EdgeInsets.symmetric(vertical: 5.5),
                    decoration: BoxDecoration(
                      color:
                          isCorrect
                              ? const Color(0xFFF4FBF6)
                              : Colors.transparent,
                      border: Border.all(
                        color:
                            isCorrect
                                ? const Color(0xFF38b000)
                                : Colors.grey.shade200,
                        width: isCorrect ? 1.1 : 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow:
                          isCorrect
                              ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF38b000,
                                  ).withOpacity(0.10),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : [],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 11.0,
                        horizontal: 14,
                      ),
                      child: inlineTextWithImages(
                        "$optionLetter. $optionText", // The label is prepended here
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              isCorrect ? FontWeight.w500 : FontWeight.normal,
                          color: Colors.black,
                          height: 1.35,
                        ),
                        imageMaxWidth: 300,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildReportButton(
                  text: AppStrings.reportQue,
                  icon: Icons.flag_outlined,
                  onPressed: () {
                    showDialog(
                      barrierColor: Colors.black.withOpacity(0.07),
                      context: context,
                      builder:
                          (_) => ReportQuestionDialog(
                            fileId: AppStrings.fileId,
                            questionId: widget.question.id,
                            questionIndex: widget.questionIndex,
                          ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                _buildPrimaryButton(
                  text:
                      !_showAnswer
                          ? AppStrings.showAnswer
                          : AppStrings.hideAnswer,
                  icon:
                      !_showAnswer
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                  onPressed: () {
                    setState(() => _showAnswer = !_showAnswer);
                    widget.onContentChanged();
                  },
                ),
              ],
            ),
            if (_showAnswer) ...[
              const Divider(height: 32, thickness: 1.1),
              if (hasCorrectAnswer)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Correct Answer:",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        convertIndicesToLetters(
                          widget.question.correctAnswerIndices,
                        ),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      _buildReportButton(
                        text: AppStrings.reportAnswerAsIncorrect,
                        icon: Icons.warning_amber_rounded,
                        onPressed: () {
                          context
                              .read<ReportAnsCubit>()
                              .reportAnswerAsIncorrect(widget.question);
                          showDialog(
                            barrierColor: Colors.black.withOpacity(0.1),
                            context: context,
                            builder:
                                (_) => ReportIncorrectAnswerDialog(
                                  questionId: widget.question.id,
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              if (hasExplanation) ...[
                const SizedBox(height: 18),
                _buildLabel("Explanation"),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: inlineTextWithImages(
                    widget.question.answerExplanation,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15.5,
                      height: 1.33,
                    ),
                    imageMaxWidth: 350,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _buildReportButton(
                    text: AppStrings.reportExplanation,
                    icon: Icons.report_gmailerrorred,
                    onPressed: () {
                      showDialog(
                        barrierColor: Colors.black.withOpacity(0.1),
                        context: context,
                        builder:
                            (_) => ReportExplanationDialogue(
                              questionId: widget.question.id,
                              fileId: AppStrings.fileId,
                            ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  String convertIndicesToLetters(List<int> indices) =>
      indices.map((i) => String.fromCharCode(65 + i)).join(", ");
}
