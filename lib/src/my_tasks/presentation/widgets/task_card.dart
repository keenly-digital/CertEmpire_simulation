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
        double iconSize = width * 0.02;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.task, width: iconSize, height: iconSize),
                const SizedBox(width: 8),
                Text(
                  task?.reason ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                Text('  |  ', style: TextStyle(color: Colors.black)),
                Expanded(
                  child: Text(
                    "This is the content of the question. This is the content of the question...",
                  ),
                ),
                Text(
                  "Requested on:",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  convertDate(task?.requestedAt ?? ""),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(width: 30,),
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
                      horizontal: 24,
                      vertical: 4,
                    ),
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.white
                  ),
                  child: Text(
                    "View",
                    style: TextStyle(color: AppColors.purple, fontSize: 13),
                  ),
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
