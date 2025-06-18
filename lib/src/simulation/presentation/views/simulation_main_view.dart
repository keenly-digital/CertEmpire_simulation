import 'dart:html' as html;

import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/core/shared/widgets/spaces.dart';
import 'package:certempiree/core/shared/widgets/toast.dart';
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

/// Main page showing exam questions with pagination inside an iframe.
class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({super.key});

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  int pageNumber = 1;
  final GlobalKey _contentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    fetchSimulationData();
  }

  /// Send height (and optionally scroll) to parent window.
  void _postToParent({bool scrollToTop = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (box == null) return;
      final logicalHeight = box.size.height;
      final dpr = html.window.devicePixelRatio;
      final cssHeight = logicalHeight * dpr;
      final message = {
        'iframeHeight': cssHeight,
        if (scrollToTop) 'scrollToTop': true,
      };
      print('Responce fron flutter: $cssHeight $scrollToTop');
      html.window.parent?.postMessage(
        message,
        'https://staging2.certempire.com/',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulationBloc, SimulationInitState>(
      builder: (context, state) {
        final simulationState = state as SimulationState;
        final total = state.totalItemLength ?? 0;
        final currentCount = simulationState.simulationData?.items.length ?? 0;
        final canNext = currentCount < total;

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
                        final isWide = constraints.maxWidth > 852;
                        return BlocBuilder<SearchQuestionCubit, String>(
                          builder: (context, query) {
                            // Initial measure without scrolling
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              () => _postToParent(),
                            );

                            return SingleChildScrollView(
                              child: Column(
                                key: _contentKey,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildHeader(
                                    context,
                                    simulationState,
                                    isWide,
                                  ),
                                  verticalSpace(6),
                                  FileContentWidget(
                                    fileContent:
                                        simulationState.simulationData ??
                                        FileContent(),
                                    searchQuery: query,
                                    onContentChanged: () => _postToParent(),
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Showing $pageNumber to $currentCount of $total results",
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed:
                                                      pageNumber > 1
                                                          ? () {
                                                            setState(
                                                              () =>
                                                                  pageNumber--,
                                                            );
                                                            fetchSimulationData();
                                                            // after page change, scroll parent to top
                                                            _postToParent(
                                                              scrollToTop: true,
                                                            );
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
                                                            setState(
                                                              () =>
                                                                  pageNumber++,
                                                            );
                                                            fetchSimulationData();
                                                            _postToParent(
                                                              scrollToTop: true,
                                                            );
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
                                  ),
                                ],
                              ),
                            );
                          },
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
    SimulationState state,
    bool isWide,
  ) {
    final fileName = state.simulationData?.fileName ?? '';
    final title = Text(
      fileName,
      style: context.textTheme.headlineSmall?.copyWith(
        color: AppColors.blue,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.blue,
      ),
    );

    final search = SizedBox(
      width: 400,
      child: TextFormField(
        onChanged: (val) => context.read<SearchQuestionCubit>().setQuery(val),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
          labelText: 'Search',
          labelStyle: const TextStyle(color: AppColors.black),
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );

    final download = appButton(
      withIcon: true,
      onPressed: () {},
      text: 'Download',
      textColor: Colors.white,
      borderColor: AppColors.lightBlue,
      background: AppColors.lightBlue,
    );

    if (isWide) {
      return Row(
        children: [
          title,
          const Spacer(),
          search,
          const SizedBox(width: 8),
          download,
        ],
      );
    }
    return Wrap(spacing: 8, runSpacing: 8, children: [title, search, download]);
  }

  /// Builds page arrow button graphics
  Widget _buildPageButton(IconData icon, {bool disabled = false}) {
    return Container(
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
  }

  void fetchSimulationData() {
    context.read<SimulationBloc>().add(
      FetchSimulationDataEvent(
        fieldId: AppStrings.fileId,
        pageNumber: pageNumber,
      ),
    );
  }
}
