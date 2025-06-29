import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, this.task});

  final TaskItem? task;

  @override
  Widget build(BuildContext context) {
    // Reusable "View" button to avoid code duplication.
    // The business logic call remains completely untouched.
    final viewButton = OutlinedButton(
      onPressed: () {
        context.read<GetAllTaskBloc>().dialogueSelection(task, context);
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: AppColors.purple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: Colors.white,
      ),
      child: const Text(
        "View",
        style: TextStyle(color: AppColors.purple, fontSize: 13),
      ),
    );

    // The LayoutBuilder is used to check the screen width and switch layouts.
    return LayoutBuilder(
      builder: (context, constraints) {
        // The breakpoint is set to 600px as requested.
        final bool isWide = constraints.maxWidth > 600;

        // Use the original Row layout for wide screens.
        if (isWide) {
          return buildWideLayout(viewButton);
        }
        // Use the new Column layout for narrow screens.
        else {
          return buildNarrowLayout(viewButton);
        }
      },
    );
  }

  /// Builds the layout for wide screens (> 600px).
  Widget buildWideLayout(Widget viewButton) {
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
          children: [
            Image.asset(Assets.task, width: 24, height: 24),
            const SizedBox(width: 8),
            Container(
              constraints: BoxConstraints(maxWidth: 125.w),
              child: Text(
                task?.reason ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 13,
                ),
              ),
            ),
            const Text('  |  ', style: TextStyle(color: Colors.black)),
            const Expanded(
              child: Text(
                maxLines: 8,
                "View the question content here...",
                style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Requested on: ${convertDate(task?.requestedAt ?? "")}",
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 16),
            viewButton,
          ],
        ),
      ),
    );
  }

  /// Builds the layout for narrow screens (< 600px).
  Widget buildNarrowLayout(Widget viewButton) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFF5F8FC),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Icon and Reason
            Row(
              children: [
                Image.asset(Assets.task, width: 22, height: 22),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    task?.reason ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.only(left: 30), // Indent content
              child: Text(
                "View the question content here...",
                maxLines: 8,
                style: TextStyle(fontSize: 13, overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(height: 16),
            // Row for Date and View Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "On: ${convertDate(task?.requestedAt ?? "")}",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                ),
                viewButton,
              ],
            ),
          ],
        ),
      ),
    );
  }

  // This helper function remains unchanged.
  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return '';
    }
  }
}
