import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/src/simulation/data/models/file_content_model.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_event.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';
import 'package:certempiree/src/simulation/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:certempiree/src/simulation/presentation/views/file_content.dart';
import 'package:certempiree/src/simulation/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/log_util.dart';

class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({super.key});

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  @override
  void initState() {
    super.initState();
    if (!mounted) return;

    context.read<SimulationBloc>().add(
      FetchSimulationDataEvent(fieldId: AppStrings.fileId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulationBloc, SimulationInitState>(
      builder: (context, state) {
        final simulationState = state as SimulationState;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                simulationState.loading
                    ? const Center(
                      child: CircularProgressIndicator(color: AppColors.purple),
                    )
                    : LayoutBuilder(
                      builder: (context, constraints) {
                        final isWideScreen = constraints.maxWidth > 852;

                        return Column(
                          children: [
                            _buildHeader(
                              context,
                              simulationState,
                              isWideScreen,
                            ),
                            verticalSpace(6),
                            BlocBuilder<SearchQuestionCubit, String>(
                              builder: (context, query) {
                                return Expanded(
                                  child: FileContentWidget(
                                    fileContent:
                                        simulationState.simulationData ??
                                        FileContent(),
                                    searchQuery: query,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    SimulationState simulationState,
    bool isWideScreen,
  ) {
    final fileName =
        simulationState.simulationData?.fileName.replaceAll("%", "") ?? "";

    final fileNameText = Text(
      fileName,
      style: context.textTheme.headlineSmall?.copyWith(
        color: AppColors.blue,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.blue,
      ),
    );

    final searchField = SizedBox(
      width: 400,
      child: TextFormField(
        onChanged:
            (value) => context.read<SearchQuestionCubit>().setQuery(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          labelText: 'Search',
          labelStyle: const TextStyle(color: AppColors.black),
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
          hintStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );

    final downloadButton = appButton(
      withIcon: true,
      onPressed: () {
        // Add download functionality here
      },
      text: "Download",
      textColor: Colors.white,
      borderColor: AppColors.lightBlue,
      background: AppColors.lightBlue,
    );

    if (isWideScreen) {
      return Row(
        children: [
          fileNameText,
          const Spacer(),
          searchField,
          horizontalSpace(5),
          downloadButton,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            fileNameText,
            searchField,
            horizontalSpace(5),
            downloadButton,
          ],
        ),
      ],
    );
  }
}
