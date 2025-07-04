import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_state.dart';
import 'package:certempiree/src/my_tasks/presentation/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_all_task_bloc/get_all_task_bloc.dart';
import '../bloc/get_all_task_bloc/get_all_task_event.dart';

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
    return BlocBuilder<GetAllTaskBloc, GetAllTaskState>(
      builder: (context, state) {
        final moveNext =
            (state.taskItem?.length ?? 0) < (state.totalItemLength ?? 0);

        if (state.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.purple),
          );
        }
        if ((state.taskItem?.isEmpty ?? false) || (state.taskItem == null)) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14006fff),
                    blurRadius: 22,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.task_alt_rounded,
                    color: AppColors.themeBlue,
                    size: 54,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "No Pending Task",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        // Tasks exist
        return Container(
          width: double.infinity, // Full width
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 14),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.task, color: AppColors.themeBlue, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    "My Pending Tasks",
                    style: TextStyle(
                      color: AppColors.themeBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...List.generate(state.taskItem?.length ?? 0, (index) {
                final task = state.taskItem?[index];
                final isOdd = index % 2 == 1;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Card(
                    elevation: isOdd ? 2 : 0,
                    shadowColor: AppColors.themeBlue.withOpacity(0.09),
                    color: isOdd ? const Color(0xFFF7FAFE) : Colors.white,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: BorderSide(
                        color:
                            isOdd
                                ? AppColors.themeBlue.withOpacity(0.06)
                                : Colors.grey.withOpacity(0.07),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 19,
                      ),
                      child: TaskCard(task: task),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 18),
              _ModernPager(
                pageNumber: pageNumber,
                shown: state.taskItem?.length ?? 0,
                total: state.totalItemLength ?? 0,
                canPrev: pageNumber > 1,
                canNext: moveNext,
                onPrev: () {
                  if (pageNumber > 1) {
                    setState(() => pageNumber--);
                    fetchTasks();
                  }
                },
                onNext: () {
                  if (moveNext) {
                    setState(() => pageNumber++);
                    fetchTasks();
                  } else {
                    CommonHelper.showToast(message: "No More Tasks");
                  }
                },
              ),
              const SizedBox(height: 4),
            ],
          ),
        );
      },
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

// _ModernPager remains unchanged.
class _ModernPager extends StatelessWidget {
  final int pageNumber;
  final int shown;
  final int total;
  final bool canPrev;
  final bool canNext;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _ModernPager({
    required this.pageNumber,
    required this.shown,
    required this.total,
    required this.canPrev,
    required this.canNext,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      // Full width
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.themeBlue.withOpacity(0.12)),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f006fff),
            blurRadius: 9,
            offset: Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Showing $pageNumber to $shown of $total results",
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontSize: 15.2,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: canPrev ? onPrev : null,
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: canPrev ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Previous",
              ),
              IconButton(
                onPressed: canNext ? onNext : null,
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: canNext ? AppColors.themeBlue : Colors.grey,
                ),
                tooltip: "Next",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
