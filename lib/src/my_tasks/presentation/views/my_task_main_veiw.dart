import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/my_tasks/presentation/bloc/get_all_task_bloc/get_all_task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    taskDependencies();

    context.read<GetAllTaskBloc>().add(
      GetAllTaskEvent(userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetAllTaskBloc, GetAllTaskState>(
        builder: (context, state) {
          return state.isLoading == true
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TaskCard();
                },
              );
        },
      ),
    );
  }
}
