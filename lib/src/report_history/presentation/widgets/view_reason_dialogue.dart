import 'package:certempiree/src/report_history/data/models/get_all_reports.dart';
import 'package:certempiree/src/report_history/presentation/bloc/report_bloc/get_all_report_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../bloc/report_bloc/get_all_report_state.dart';

class ViewReasonDialog extends StatelessWidget {
  final ReportData reportData;

  const ViewReasonDialog({super.key, required this.reportData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;

    return Dialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.deepPurple, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: dialogWidth,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "View Reason",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.deepPurple),

              /// Exam Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Exam Name: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      reportData.examName ?? "",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              /// Status
              Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    reportData.status ?? "",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(),

              /// Explanation title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Explanation",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              /// Explanation content
              BlocBuilder<GetAllReportsBloc, ReportInitialState>(
                builder: (context, state) {
                  if (state is GetAllReportState) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: state.reasonLoading == true
                          ? const Center(child: CircularProgressIndicator(
                  color: AppColors.purple,))
                          : Text(
                        state.explanation ?? "",
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
