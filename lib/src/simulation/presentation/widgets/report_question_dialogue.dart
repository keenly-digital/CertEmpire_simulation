import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/submit_report_param.dart';

class ReportQuestionDialog extends StatefulWidget {
  final int? questionId;
  final String? fileId;
  final int? questionIndex;

  const ReportQuestionDialog({
    super.key,
    this.questionId,
    this.fileId,
    this.questionIndex,
  });

  @override
  _ReportQuestionDialogState createState() => _ReportQuestionDialogState();
}

class _ReportQuestionDialogState extends State<ReportQuestionDialog> {
  String? _selectedReason;
  final TextEditingController _explanationController = TextEditingController();

  @override
  void dispose() {
    _explanationController.dispose();
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.90;

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
                        Icons.flag_outlined,
                        color: AppColors.themePurple,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.reportQue,
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
                    icon: const Icon(Icons.close, color: AppColors.themePurple),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
            ),
            // Content Area
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.chooseCriteria,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Using RadioListTile for better layout and interaction
                    Theme(
                      data: Theme.of(
                        context,
                      ).copyWith(unselectedWidgetColor: AppColors.themePurple),
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Question is Outdated'),
                            value: 'Outdated',
                            groupValue: _selectedReason,
                            onChanged:
                                (val) => setState(() => _selectedReason = val),
                            activeColor: AppColors.themePurple,
                            contentPadding: EdgeInsets.zero,
                          ),
                          RadioListTile<String>(
                            title: const Text('Question is framed wrong'),
                            value: 'Framed Wrong',
                            groupValue: _selectedReason,
                            onChanged:
                                (val) => setState(() => _selectedReason = val),
                            activeColor: AppColors.themePurple,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Please provide a brief explanation:*',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Lighter Text Area
                    TextField(
                      controller: _explanationController,
                      maxLines: 6,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "This question is outdated because...",
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
                          if (_explanationController.text.trim().isEmpty ||
                              (_selectedReason?.isEmpty ?? true)) {
                            CommonHelper.showToast(
                              message: "Reason and explanation are required",
                            );
                            return;
                          }

                          final submitReportParam = SubmitQuestionReportParam(
                            explanation: _explanationController.text,
                            type: ReportTypeEnum.Question.name,
                            userId: AppStrings.userId,
                            targetId: widget.questionId ?? 0,
                            reason: _selectedReason,
                            fileId: widget.fileId,
                            questionNumber: "Question ${widget.questionIndex}",
                          );
                          context.read<SimulationBloc>().submitQuestionReport(
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
            ),
          ],
        ),
      ),
    );
  }
}
