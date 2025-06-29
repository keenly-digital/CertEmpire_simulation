import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/my_tasks/data/models/my_task_model.dart';
import 'package:certempiree/src/my_tasks/data/models/vote_task_param_model.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/spaces.dart';

class QuestionExplanationTask extends StatefulWidget {
  const QuestionExplanationTask({super.key, this.taskItem, this.approved});

  final TaskItem? taskItem;
  final bool? approved;

  @override
  State<QuestionExplanationTask> createState() =>
      _QuestionExplanationTaskState();
}

class _QuestionExplanationTaskState extends State<QuestionExplanationTask> {
  // The controller is declared here to preserve its state across rebuilds.
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // The controller is initialized once when the widget is created.
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // The controller is disposed of when the widget is removed to prevent memory leaks.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // --- Responsive Sizing (Preserved) ---
        final bool isWide = constraints.maxWidth > 600;
        final double dialogWidth = isWide ? 450 : constraints.maxWidth * 0.9;
        final double padding = isWide ? 20 : 16;
        final double fontSizeSmall = isWide ? 14 : 12;
        final double fontSizeMedium = isWide ? 15 : 13;
        final double fontSizeLarge = isWide ? 16 : 14;

        return ConstrainedBox(
          constraints: BoxConstraints(
            // Adjusted maxHeight to better fit content without excessive scrolling
            maxHeight: 0.80.sh,
            maxWidth: dialogWidth,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.purple, width: 2),
            ),
            child: Container(
              width: dialogWidth,
              padding: EdgeInsets.all(padding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Header ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            "Write an explanation to this selection",
                            style: TextStyle(
                              fontSize: fontSizeLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        horizontalSpace(16),
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            Assets.cross,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(4),
                    Text(
                      "Write reason and explanation to why it is the right choice",
                      style: TextStyle(
                        fontSize: fontSizeSmall,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    verticalSpace(12),

                    // --- TextField ---
                    TextField(
                      controller: _controller, // Using the stateful controller
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: "Enter your explanation here...",
                        hintStyle: TextStyle(
                          fontSize: fontSizeMedium,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.purple,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.purple.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: AppColors.purple,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(20),

                    // --- RESPONSIVE ACTION BUTTONS ---
                    // The new method builds a Row or Column based on screen width.
                    _buildActionButtons(context, isWide, fontSizeLarge),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the action buttons adaptively.
  /// Returns a [Row] for wide screens and a [Column] for narrow screens.
  Widget _buildActionButtons(
    BuildContext context,
    bool isWide,
    double fontSize,
  ) {
    // Define the "Go Back" button.
    final goBackButton = OutlinedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.deepPurple),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        AppStrings.goBack,
        style: TextStyle(fontSize: fontSize, color: AppColors.darkPurple),
      ),
    );

    // Define the "Submit" button.
    // The business logic here remains completely untouched.
    final submitButton = ElevatedButton(
      onPressed: () {
        VoteTaskParamModel voteTaskParamModel = VoteTaskParamModel(
          taskId: widget.taskItem?.taskId,
          explanation:
              _controller.text, // Using text from the stateful controller
          decision: widget.approved == true ? "Approved" : "Unapproved",
        );
        context.read<GetAllTaskBloc>().voteTask(context, voteTaskParamModel);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Text(
        AppStrings.submit,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
    );

    // If the screen is wide, return a Row.
    if (isWide) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [goBackButton, submitButton],
      );
    }

    // Otherwise, return a Column for narrow screens.
    // CrossAxisAlignment.stretch makes the buttons fill the width.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        submitButton, // Primary action first
        verticalSpace(8),
        goBackButton,
      ],
    );
  }
}
