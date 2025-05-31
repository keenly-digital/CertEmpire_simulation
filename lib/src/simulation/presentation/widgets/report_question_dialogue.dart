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
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dialogWidth = screenWidth > 600 ? 400 : screenWidth * 0.75;

    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: dialogWidth,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.reportQue,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.chooseCriteria,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.0,
                      child: Radio<String>(
                        value: 'Outdated',
                        groupValue: _selectedReason,
                        onChanged:
                            (val) => setState(() => _selectedReason = val),
                      ),
                    ),
                    const Text(
                      'Question is Outdated',
                      style: TextStyle(fontSize: 11),
                    ),
                    const SizedBox(width: 6),
                    Transform.scale(
                      scale: 1.0,
                      child: Radio<String>(
                        value: 'Framed Wrong',
                        groupValue: _selectedReason,
                        onChanged:
                            (val) => setState(() => _selectedReason = val),
                      ),
                    ),
                    const Text(
                      'Question is framed wrong',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Write An Explanation To This Report. *',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(

                  controller: _explanationController,
                  maxLines: 6,
                  style: const TextStyle(fontSize: 14),
                  decoration:  InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:  BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 1.5),
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      if (_explanationController.text.isEmpty ||
                          (_selectedReason?.isEmpty ?? true)) {
                        CommonHelper.showToast(
                          message: "Reason And Explanation Is Required",
                        );
                        return;
                      }

                      final submitReportParam = SubmitQuestionReportParam(
                        explanation: _explanationController.text,
                        type: ReportTypeEnum.Question.index,
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
                    },
                    child: const Text('SUBMIT', style: TextStyle(fontSize: 14)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
