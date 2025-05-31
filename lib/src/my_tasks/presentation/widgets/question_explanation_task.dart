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

class QuestionExplanationTask extends StatelessWidget {
  const QuestionExplanationTask({super.key, this.taskItem, this.approved});


  final TaskItem? taskItem;
  final bool? approved;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double dialogWidth = width > 600 ? 450 : width * 0.7;

        double padding = width > 600 ? 20 : 12;
        double fontSizeSmall = width > 600 ? 14 : 12;
        double fontSizeMedium = width > 600 ? 15 : 13;
        double fontSizeLarge = width > 600 ? 16 : 14;

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.55.sh,
            maxWidth: dialogWidth,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.purple, width: 2),
            ),
            child: Center(
              child: Container(
                width: dialogWidth,
                padding: EdgeInsets.all(padding),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset(
                              Assets.cross,
                              height: 20,
                              width: 20,
                            ),
                          ),
                        ],
                      ),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Write reason and explanation to why it is the right choice",
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextField(
                        controller: controller,
                        maxLines: 7,
                        decoration: InputDecoration(
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
                        ),
                      ),
                      verticalSpace(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.deepPurple),
                              // Purple border
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ), // Optional: Rounded corners
                              ),
                            ),
                            child: Text(
                              AppStrings.goBack,
                              style: TextStyle(
                                fontSize: fontSizeLarge,
                                color:
                                    AppColors
                                        .darkPurple, // Optional: Purple text to match
                              ),
                            ),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  4,
                                ), // Optional: Rounded corners
                              ),
                            ),

                            onPressed: () {
                              VoteTaskParamModel voteTaskParamModel =
                                  VoteTaskParamModel(
                                    taskId: taskItem?.taskId,
                                    explanation: controller.text,
                                    decision:
                                        approved == true
                                            ? "Approved"
                                            : "Unapproved",
                                  );
                              context.read<GetAllTaskBloc>().voteTask(
                                context,
                                voteTaskParamModel,
                              );
                            },
                            child: Text(
                              AppStrings.submit,
                              style: TextStyle(fontSize: fontSizeLarge),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
