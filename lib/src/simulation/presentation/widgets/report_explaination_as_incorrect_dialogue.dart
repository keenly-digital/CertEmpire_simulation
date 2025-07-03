import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/submit_report_param.dart';

class ReportExplanationDialogue extends StatefulWidget {
  final int? questionId;
  final String? fileId;

  const ReportExplanationDialogue({super.key, this.questionId, this.fileId});

  @override
  State<ReportExplanationDialogue> createState() =>
      _ReportExplanationDialogueState();
}

class _ReportExplanationDialogueState extends State<ReportExplanationDialogue> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Helper for the primary submit button
  Widget _buildSubmitButton({
    required VoidCallback onPressed,
    required double dialogWidth,
  }) {
    return SizedBox(
      width: dialogWidth * 0.6,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.send_rounded, size: 20),
        label: const Text("Submit Report"),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.themePurple,
          elevation: 2,
          padding: const EdgeInsets.symmetric(vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
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
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.themePurple, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          insetPadding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: dialogWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Modern Header with Gradient and Close Icon
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
                            AppColors.lightBackgroundpurple.withOpacity(0.8),
                            AppColors.lightBackgroundpurple,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.report_gmailerrorred_rounded,
                            color: AppColors.themePurple,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            AppStrings.reportExplanation,
                            style: const TextStyle(
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
                // Content Area
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.explanationBelow,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Lighter Text Area
                      TextField(
                        controller: _controller,
                        maxLines: 7,
                        style: const TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: "This explanation is incorrect because...",
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
                      // Submit Button
                      Center(
                        child: _buildSubmitButton(
                          dialogWidth: dialogWidth,
                          onPressed: () {
                            final submitReportParam = SubmitQuestionReportParam(
                              explanation: _controller.text,
                              type: ReportTypeEnum.Explanation.name,
                              userId: AppStrings.userId,
                              targetId: widget.questionId ?? 0,
                              reason: "Wrong Explanation",
                              fileId: widget.fileId ?? "",
                              questionNumber: "",
                              orderId: AppStrings.orderId,
                            );

                            print("object..... ${AppStrings.orderId}")
;                            context
                                .read<SimulationBloc>()
                                .submitExplanationReport(
                                  submitReportParam,
                                  context,
                                );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
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
