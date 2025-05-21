import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/widgets/report_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/submit_report_param.dart';

class ReportExplanationDialogue extends StatelessWidget {
  final int? questionId;
  final String? fileId;

   ReportExplanationDialogue({super.key, this.questionId, this.fileId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        final dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;

        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            side:  BorderSide(color: Colors.red, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: dialogWidth,
            child: Padding(
              padding:  EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.reportExplanation,
                      style:  TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                      ),
                    ),
                     SizedBox(height: 15),
                    Text(
                      AppStrings.explanationBelow,
                      style:  TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                     SizedBox(height: 10),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller: _controller,
                        maxLines: null,
                        expands: true,
                        style:  TextStyle(fontSize: 14),
                        decoration:  InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                     SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side:  BorderSide(color: Colors.red, width: 1.5),
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () {
                          final submitReportParam = SubmitQuestionReportParam(
                            explanation: _controller.text,
                            type: ReportTypeEnum.Explanation.index,
                            userId: AppStrings.userId,
                            targetId: questionId ?? 0,
                            reason: "",
                            fileId: fileId ?? "",
                            questionNumber: "",
                          );
                          context.read<SimulationBloc>().submitExplanationReport(
                            submitReportParam,
                            context,
                          );
                          Navigator.pop(context);
                        },
                        child:  Text(
                          AppStrings.submit,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
