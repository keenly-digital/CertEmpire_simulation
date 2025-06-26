// import 'dart:html' as html;

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

class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({Key? key}) : super(key: key);

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  int pageNumber = 1;
  final GlobalKey _contentKey = GlobalKey();

  double _lastSentHeight = 0;
  static const double _heightThreshold = 30;

  @override
  void initState() {
    super.initState();
    // fetchSimulationData();
  }

  /// Sends iframe height update to parent (only if delta ≥ threshold or forced)
  // void _sendHeight({bool scrollToTop = false}) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
  //     if (box == null) return;
  //     final cssHeight = box.size.height * html.window.devicePixelRatio;
  //     if (!scrollToTop &&
  //         (cssHeight - _lastSentHeight).abs() < _heightThreshold)
  //       return;
  //     _lastSentHeight = cssHeight;
  //     html.window.parent?.postMessage({
  //       'iframeHeight': cssHeight.toInt(),
  //       if (scrollToTop) 'scrollToTop': true,
  //     }, 'https://staging2.certempire.com/');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulationBloc, SimulationInitState>(
      listener: (context, state) {
        if (state is SimulationState && !state.loading) {
          // _sendHeight(scrollToTop: true);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<SimulationBloc, SimulationInitState>(
            builder: (context, state) {
              final simulationState = state as SimulationState;
              if (simulationState.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.themePurple,
                  ),
                );
              }

              final totalCount = simulationState.totalItemLength ?? 0;
              final currentCount =
                  simulationState.simulationData?.items.length ?? 0;
              final canNext = currentCount < totalCount;

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 852;
                  return BlocBuilder<SearchQuestionCubit, String>(
                    builder: (context, query) {
                      if (_lastSentHeight == 0) {
                        Future.delayed(
                          const Duration(milliseconds: 200),
                          // _sendHeight,
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          key: _contentKey,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildHeader(context, simulationState, isWide),
                            verticalSpace(6),
                            FileContentWidget(
                              fileContent:
                                  simulationState.simulationData ??
                                  FileContent(),
                              searchQuery: query,
                              onContentChanged:
                                  ({bool scrollToTop = false}) => {},
                            ),
                            const SizedBox(height: 16),
                            _buildPagination(currentCount, totalCount, canNext),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPagination(int current, int total, bool canNext) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Showing $pageNumber to $current of $total results'),
              Row(
                children: [
                  IconButton(
                    onPressed:
                        pageNumber > 1
                            ? () {
                              setState(() => pageNumber--);
                              fetchSimulationData();
                            }
                            : null,
                    icon: _buildPageButton(
                      Icons.arrow_back,
                      disabled: pageNumber <= 1,
                    ),
                  ),
                  IconButton(
                    onPressed:
                        canNext
                            ? () {
                              setState(() => pageNumber++);
                              fetchSimulationData();
                            }
                            : null,
                    icon: _buildPageButton(
                      Icons.arrow_forward,
                      disabled: !canNext,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    SimulationState state,
    bool isWide,
  ) {
    final fileName = state.simulationData?.fileName ?? '';
    final title = Text(
      fileName,
      style: context.textTheme.headlineSmall?.copyWith(
        color: AppColors.themeBlue,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.themeBlue,
      ),
    );
    final searchField = SizedBox(
      width: 400,
      child: TextFormField(
        onChanged: (v) => context.read<SearchQuestionCubit>().setQuery(v),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          hintText: 'Search',
          hintStyle: const TextStyle(color: AppColors.black),
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
    final downloadButton = appButton(
      withIcon: true,
      onPressed: () {},
      text: 'Download',
      textColor: Colors.white,
      borderColor: AppColors.themePurple,
      background: AppColors.themePurple,
    );
    if (isWide) {
      return Row(
        children: [
          title,
          const Spacer(),
          searchField,
          const SizedBox(width: 8),
          downloadButton,
        ],
      );
    }
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [title, searchField, downloadButton],
    );
  }

  Widget _buildPageButton(IconData icon, {bool disabled = false}) => Container(
    width: 30,
    height: 60,
    decoration: BoxDecoration(
      border: Border.all(color: disabled ? Colors.black45 : Colors.black),
    ),
    alignment: Alignment.center,
    child: Icon(
      icon,
      size: 20,
      color: disabled ? Colors.black45 : Colors.black,
    ),
  );

  void fetchSimulationData() {
    context.read<SimulationBloc>().add(
      FetchSimulationDataEvent(
        fieldId: AppStrings.fileId,
        pageNumber: pageNumber,
      ),
    );
  }
}
