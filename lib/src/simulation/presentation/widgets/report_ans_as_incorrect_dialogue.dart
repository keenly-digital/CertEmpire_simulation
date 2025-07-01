import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_cubit.dart';
import 'package:certempiree/src/simulation/presentation/cubit/report_ans_state.dart';
import 'package:certempiree/src/simulation/presentation/views/editor/editor_view.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/report_ans_param_model.dart';
import '../../data/models/submit_report_param.dart';

class ReportIncorrectAnswerDialog extends StatefulWidget {
  final int? questionId;

  const ReportIncorrectAnswerDialog({super.key, this.questionId});

  @override
  State<ReportIncorrectAnswerDialog> createState() =>
      _ReportIncorrectAnswerDialogState();
}

class _ReportIncorrectAnswerDialogState
    extends State<ReportIncorrectAnswerDialog> {
  late final TextEditingController explanationController;

  @override
  void initState() {
    super.initState();
    explanationController = TextEditingController();
  }

  @override
  void dispose() {
    explanationController.dispose();
    super.dispose();
  }

  /// Helper for the primary submit button
  Widget _buildSubmitButton({
    required VoidCallback onPressed,
    required double dialogWidth,
  }) {
    return Center(
      child: SizedBox(
        width: dialogWidth * 0.6,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.send_rounded, size: 20),
          label: const Text("Submit Report"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.themePurple,
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.90;

        return Dialog(
          // --- CHANGE 2: Thinner, more subtle border ---
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.themePurple, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: dialogWidth,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: BlocBuilder<ReportAnsCubit, ReportAnswerState>(
                builder: (context, reportAndQuestionState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --- CHANGE 1 & 4: Header with Gradient and Close Icon ---
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.lightBackgroundpurple.withOpacity(
                                    0.8,
                                  ),
                                  AppColors.lightBackgroundpurple,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning_amber_rounded,
                                  color: AppColors.themePurple,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Report Answer as Incorrect",
                                  style: TextStyle(
                                    color: AppColors.themePurple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: AppColors.themePurple,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Which option do you believe is correct?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    reportAndQuestionState
                                        .question
                                        ?.options
                                        .length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final optionText =
                                      reportAndQuestionState
                                          .question
                                          ?.options[index] ??
                                      "";
                                  final isSelected = reportAndQuestionState
                                      .selectedOptionIndices
                                      .contains(index);
                                  return _SelectableOption(
                                    isSelected: isSelected,
                                    onTap: () {
                                      context
                                          .read<ReportAnsCubit>()
                                          .toggleOptionSelection(index);
                                    },
                                    child: EditorView(
                                      initialContent: optionText,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Please provide a brief explanation:",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // --- CHANGE 3: Lighter Text Area ---
                              TextField(
                                controller: explanationController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText:
                                      "My suggested answer is correct because...",
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                  hintStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.themePurple,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              _buildSubmitButton(
                                dialogWidth: dialogWidth,
                                onPressed: () async {
                                  if (explanationController.text
                                      .trim()
                                      .isEmpty) {
                                    CommonHelper.showToast(
                                      message: "Please provide an explanation",
                                    );
                                    return;
                                  }
                                  if ((reportAndQuestionState
                                              .question
                                              ?.options
                                              .isNotEmpty ??
                                          false) &&
                                      reportAndQuestionState
                                          .selectedOptionIndices
                                          .isEmpty) {
                                    CommonHelper.showToast(
                                      message:
                                          "Please select your suggested answer",
                                    );
                                    return;
                                  }

                                  final reportParams = ReportAnsParamsModel(
                                    indexes:
                                        reportAndQuestionState
                                            .selectedOptionIndices,
                                    submitQuestionReportParam:
                                        SubmitQuestionReportParam(
                                          explanation:
                                              explanationController.text,
                                          type: ReportTypeEnum.Answer.name,
                                          userId: AppStrings.userId,
                                          targetId: widget.questionId ?? 0,
                                          reason: "Answer is Incorrect",
                                          fileId: AppStrings.fileId,
                                          questionNumber:
                                              "Question ${widget.questionId}",
                                        ),
                                  );

                                  await context
                                      .read<ReportAnsCubit>()
                                      .submitReport(reportParams, context);

                                  if (mounted) {
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
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

/// A stateful widget to handle hover effects for selectable options.
class _SelectableOption extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  const _SelectableOption({
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  @override
  __SelectableOptionState createState() => __SelectableOptionState();
}

class __SelectableOptionState extends State<_SelectableOption> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform:
              _isHovering
                  ? (Matrix4.translationValues(0, -4, 0))
                  : Matrix4.identity(),
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color:
                widget.isSelected
                    ? AppColors.lightBackgroundpurple
                    : Colors.white,
            border: Border.all(
              color:
                  widget.isSelected
                      ? AppColors.themePurple
                      : _isHovering
                      ? AppColors.themePurple.withOpacity(0.5)
                      : Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow:
                _isHovering || widget.isSelected
                    ? [
                      BoxShadow(
                        color: AppColors.themePurple.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
