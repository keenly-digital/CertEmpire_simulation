import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/simulation/data/models/file_content_model.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';
import 'package:certempiree/src/simulation/presentation/views/file_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/shared/widgets/spaces.dart';
import '../../../../main.dart';
import '../bloc/simulation_bloc/simulation_event.dart';
import '../widgets/app_button.dart';

class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({super.key});

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (!mounted) return;
      context.read<SimulationBloc>().add(
        FetchSimulationDataEvent(fieldId: AppStrings.fileId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulationBloc, SimulationInitState>(
      builder: (context, simulationState) {
        var simulationData = simulationState as SimulationState;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                simulationData.loading == true
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            simulationState.simulationData?.fileName ?? "",
                            style: context.textTheme.headlineSmall,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.w,
                                    ),
                                    labelText: 'Search',
                                    hintStyle: TextStyle(color: Colors.black),
                                    labelStyle: TextStyle(color: Colors.black),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              horizontalSpace(5),
                              appButton(
                                onPressed: () {},
                                text: "Save In Account",
                                textColor: Colors.black,
                              ),
                              horizontalSpace(5),
                              appButton(
                                withIcon: true,
                                onPressed: () {},
                                text: "Save In Account",
                                textColor: Colors.white,
                                borderColor: AppColors.darkPrimary,
                                background: AppColors.darkPrimary,
                              ),
                            ],
                          ),
                          Expanded(
                            child: FileContentWidget(
                              fileContent:
                                  simulationState.simulationData ??
                                  FileContent(),
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        );
      },
    );
  }
}
