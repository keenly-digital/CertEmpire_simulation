import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/res/asset.dart';
import '../../../../core/shared/widgets/toast.dart';
import '../../my_task_depenency.dart';
import '../bloc/get_all_task_bloc/get_all_task_bloc.dart';
import '../bloc/get_all_task_bloc/get_all_task_event.dart';
import '../widgets/task_card.dart';

class MyTaskMainView extends StatefulWidget {
  const MyTaskMainView({super.key});

  @override
  State<MyTaskMainView> createState() => _MyTaskMainViewState();
}

class _MyTaskMainViewState extends State<MyTaskMainView> {
  int pageNumber = 1;

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllTaskBloc, GetAllTaskState>(
        builder: (context, state) {
          final moveNext =
              (state.taskItem?.length ?? 0) < (state.totalItemLength ?? 0);
          return state.isLoading == true
              ? Center(
                child: CircularProgressIndicator(color: AppColors.purple),
              )
              : (state.taskItem?.isEmpty ?? false) || (state.taskItem == null)
              ? Center(
                child: Text(
                  "No Pending Task",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              )
              : Column(
                children: [
                  Image.asset(Assets.taskTop),
                  Flexible(
                    child: ListView.builder(
                      itemCount: state.taskItem?.length ?? 0,
                      itemBuilder: (context, index) {
                        final task = state.taskItem?[index];
                        return TaskCard(task: task);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60.h,
                      width: ScreenUtil().screenWidth,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Showing $pageNumber to ${state.taskItem?.length} of ${state.totalItemLength ?? 0} results",
                              style: TextStyle(color: Colors.black),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (pageNumber > 1) {
                                      setState(() {
                                        pageNumber--;
                                      });
                                      fetchTasks();
                                    }
                                  },
                                  icon: Container(
                                    width: 30,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(color: Colors.black),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.arrow_back, size: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      moveNext
                                          ? () {
                                            setState(() {
                                              pageNumber++;
                                            });
                                            fetchTasks();
                                          }
                                          : () {
                                            CommonHelper.showToast(
                                              message: "No More Reports",
                                            );
                                          },
                                  icon: Container(
                                    width: 30,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color:
                                            !moveNext
                                                ? Colors.black45
                                                : Colors.black,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                      color:
                                          !moveNext
                                              ? Colors.black45
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],

              );
        },
      ),
    );
  }

  void fetchTasks() {
    context.read<GetAllTaskBloc>().add(
      GetAllTaskEvent(
        userId: AppStrings.userId,
        pageNumber: pageNumber,
        pageSize: 10,
      ),
    );
  }
}
