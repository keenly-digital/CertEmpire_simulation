import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, this.task});

  final TaskItem? task;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        double iconSize = width * 0.04;
        double fontSizeTitle = width * 0.03;
        double fontSizeContent = width * 0.012;
        double dateFontSize = width * 0.013;
        double buttonFontSize = width * 0.025;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color(0xFFF5F8FC),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(Assets.task, width: iconSize, height: iconSize),
                const SizedBox(width: 8),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: task?.reason ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        if (task?.reason?.isNotEmpty ?? false)
                          TextSpan(
                            text: '  |',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        TextSpan(
                          text: '  ${task?.questionContent ?? ""}',
                          style: TextStyle(
                            fontSize: fontSizeContent,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      convertDate(task?.requestedAt ?? ""),
                      style: TextStyle(
                        fontSize: dateFontSize,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        context.read<GetAllTaskBloc>().dialogueSelection(
                          task,
                          context,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.purple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        visualDensity: VisualDensity.compact,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "View",
                        style: TextStyle(
                          color: AppColors.purple,
                          fontSize: buttonFontSize,
                          backgroundColor: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return '';
    }
  }
}
