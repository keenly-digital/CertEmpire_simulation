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

  /// Measures content height and sends to parent
  void _sendHeight() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final box = _contentKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final logicalHeight = box.size.height;
        final devicePixelRatio = html.window.devicePixelRatio;
        final cssPixelHeight = logicalHeight * devicePixelRatio;
        print('Logical height: $logicalHeight');
        print('devicePixelRatio: $devicePixelRatio');
        print('CSS pixel height sent: $cssPixelHeight');
        html.window.parent?.postMessage({
          'iframeHeight': cssPixelHeight,
        }, 'https://staging2.certempire.com/');
      } else {
        print('Could not measure height: RenderBox or context is null');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimulationBloc, SimulationInitState>(
      builder: (context, state) {
        final simulationState = state as SimulationState;
        final moveNext =
            (simulationState.simulationData?.items.length?? 0) < (state.totalItemLength ?? 0);
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

                        // BlocBuilder for search query to update height after search as well
                        return BlocBuilder<SearchQuestionCubit, String>(
                          builder: (context, query) {
                            // After every build, schedule height measurement
                            Future.delayed(
                              const Duration(milliseconds: 200),
                              _sendHeight,
                            );

                            return Column(
                              children: [
                                _buildHeader(
                                  context,
                                  simulationState,
                                  isWideScreen,
                                ),
                                verticalSpace(6),
                                Expanded(
                                  child: FileContentWidget(
                                    key: _contentKey,
                                    fileContent:
                                        simulationState.simulationData ??
                                        FileContent(),
                                    searchQuery: query,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Showing $pageNumber to ${simulationState.simulationData?.items.length} of ${simulationState.totalItemLength ?? 0} results",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (pageNumber > 1) {
                                                    setState(() {
                                                      pageNumber--;
                                                    });
                                                    fetchSimulationData();
                                                  }
                                                },
                                                icon: Container(
                                                  width: 30,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.rectangle,
                                                    border: Border.all(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.arrow_back,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed:
                                                    moveNext
                                                        ? () {
                                                          setState(() {
                                                            pageNumber++;
                                                          });
                                                          fetchSimulationData();
                                                        }
                                                        : () {
                                                          CommonHelper.showToast(
                                                            message:
                                                                "No More Reports",
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
    final fileName = simulationState.simulationData?.fileName ?? "";

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
      onPressed: () {},
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

  void fetchSimulationData() {
    context.read<SimulationBloc>().add(
      FetchSimulationDataEvent(
        fieldId: AppStrings.fileId,
        pageNumber: pageNumber,
      ),
    );
  }
}
