import 'package:certempiree/core/config/extensions/theme_extension.dart';

import 'package:certempiree/core/config/theme/app_colors.dart';

import 'package:certempiree/core/res/app_strings.dart';

import 'package:certempiree/core/shared/widgets/toast.dart';

import 'package:certempiree/src/simulation/data/models/file_content_model.dart';

import 'package:certempiree/src/simulation/data/models/question_model.dart';

import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';

import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_event.dart';

import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_state.dart';

import 'package:certempiree/src/simulation/presentation/cubit/search_cubit/search_cubit.dart';

import 'package:certempiree/src/simulation/presentation/views/file_content.dart';

import 'package:certempiree/src/simulation/presentation/widgets/admin_question_overview.dart';

import 'package:certempiree/src/simulation/presentation/widgets/app_button.dart';

import 'package:certempiree/src/simulation/presentation/widgets/file_casestudy_row.dart';

import 'package:certempiree/src/simulation/presentation/widgets/file_topic_row.dart';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamQuestionPage extends StatefulWidget {
  const ExamQuestionPage({Key? key}) : super(key: key);

  @override
  State<ExamQuestionPage> createState() => _ExamQuestionPageState();
}

class _ExamQuestionPageState extends State<ExamQuestionPage> {
  int pageNumber = 1;

  bool _isSingleQuestionView = true;

  int _currentQuestionIndex = 0;

  bool _shouldGoToLastItemOnLoad = false;

  int? _pendingGoToIndex;

  final TextEditingController _goToController = TextEditingController();

  bool _showGoToField = false;

  @override
  void initState() {
    super.initState();

    fetchSimulationData();
  }

  @override
  void dispose() {
    _goToController.dispose();

    super.dispose();
  }

  void fetchSimulationData() {
    context.read<SimulationBloc>().add(
      FetchSimulationDataEvent(
        fieldId: AppStrings.fileId,

        pageNumber: pageNumber,
      ),
    );
  }

  // Helper to get a flat list of all questions from the nested structure

  List<Question> _getAllQuestions(List<CommonItem> items) {
    final List<Question> questions = [];

    for (final item in items) {
      item.when(
        question: (q) => questions.add(q),

        topic: (t) => questions.addAll(_getAllQuestions(t.topicItems ?? [])),

        caseStudy:
            (cs) => questions.addAll(
              _getAllQuestions(
                cs.questions?.map((q) => CommonItem.question(q)).toList() ?? [],
              ),
            ),
      );
    }

    return questions;
  }

  CaseStudy? _findParentCaseStudy(
    Question question,
    List<CommonItem> allItems,
  ) {
    for (final item in allItems) {
      final result = item.when<CaseStudy?>(
        question: (q) => null,

        topic: (t) => _findParentCaseStudy(question, t.topicItems ?? []),

        caseStudy: (cs) {
          if (cs.questions?.any((q) => q.id == question.id) ?? false) {
            return cs;
          }

          return _findParentCaseStudy(
            question,
            cs.questions?.map((q) => CommonItem.question(q)).toList() ?? [],
          );
        },
      );

      if (result != null) return result;
    }

    return null;
  }

  Topic? _findParentTopic(Question question, List<CommonItem> allItems) {
    for (final item in allItems) {
      final result = item.when<Topic?>(
        question: (q) => null,

        caseStudy: (cs) {
          return _findParentTopic(
            question,
            cs.questions?.map((q) => CommonItem.question(q)).toList() ?? [],
          );
        },

        topic: (t) {
          final allSubQuestions = _getAllQuestions(t.topicItems ?? []);

          if (allSubQuestions.any((q) => q.id == question.id)) {
            return t;
          }

          return null;
        },
      );

      if (result != null) return result;
    }

    return null;
  }

  // --- FIX: Logic corrected to handle fetching new pages ---

  void _handleGoToQuestion(int totalQuestions) {
    final int? targetQuestion = int.tryParse(_goToController.text);

    if (targetQuestion == null ||
        targetQuestion < 1 ||
        targetQuestion > totalQuestions) {
      CommonHelper.showToast(
        message:
            "Please enter a valid question number between 1 and $totalQuestions",
      );

      return;
    }

    final newPageNumber = ((targetQuestion - 1) / 10).floor() + 1;

    final newIndex = (targetQuestion - 1) % 10;

    setState(() {
      _isSingleQuestionView = true;

      _showGoToField = false;

      if (newPageNumber == pageNumber) {
        _currentQuestionIndex = newIndex;
      } else {
        pageNumber = newPageNumber;

        _pendingGoToIndex = newIndex;

        fetchSimulationData();
      }
    });

    _goToController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SimulationBloc, SimulationInitState>(
      listener: (context, state) {
        if (state is SimulationState && !state.loading) {
          if (_shouldGoToLastItemOnLoad) {
            setState(() {
              _currentQuestionIndex =
                  (state.simulationData?.items.length ?? 1) - 1;

              _shouldGoToLastItemOnLoad = false;
            });
          }

          if (_pendingGoToIndex != null) {
            setState(() {
              _currentQuestionIndex = _pendingGoToIndex!;

              _pendingGoToIndex = null;
            });
          }
        }
      },

      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        body: BlocBuilder<SimulationBloc, SimulationInitState>(
          builder: (context, state) {
            final simulationState = state as SimulationState;

            if (simulationState.loading &&
                (simulationState.simulationData?.items.isEmpty ?? true)) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.themePurple),
              );
            }

            final originalItems = simulationState.simulationData?.items ?? [];

            final allQuestionsOnPage = _getAllQuestions(originalItems);

            final totalQuestionsInExam = simulationState.totalItemLength ?? 0;

            Topic? parentTopic;

            CaseStudy? parentCaseStudy;

            Question? currentQuestion;

            if (_isSingleQuestionView && allQuestionsOnPage.isNotEmpty) {
              if (_currentQuestionIndex >= allQuestionsOnPage.length) {
                _currentQuestionIndex = allQuestionsOnPage.length - 1;
              }

              currentQuestion = allQuestionsOnPage[_currentQuestionIndex];

              parentTopic = _findParentTopic(currentQuestion, originalItems);

              parentCaseStudy = _findParentCaseStudy(
                currentQuestion,
                originalItems,
              );
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 852;

                final horizontalPadding = isWide ? 64.0 : 16.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 24.0,
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: [
                      _buildHeader(context, simulationState, isWide),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),

                        height: _showGoToField ? 60 : 0,

                        child:
                            _showGoToField
                                ? _buildGoToField(totalQuestionsInExam)
                                : null,
                      ),

                      const SizedBox(height: 16),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(12),

                          border: Border.all(color: Colors.grey.shade200),
                        ),

                        child:
                            _isSingleQuestionView && currentQuestion != null
                                ? Column(
                                  children: [
                                    if (parentTopic != null)
                                      FileTopicRowWidget(topic: parentTopic),

                                    if (parentCaseStudy != null)
                                      FileCaseStudyRowWidget(
                                        caseStudy: parentCaseStudy,
                                      ),

                                    AdminQuestionOverviewWidget(
                                      question: currentQuestion,

                                      questionIndex: currentQuestion.q,

                                      onContentChanged:
                                          ({bool scrollToTop = false}) {},
                                    ),
                                  ],
                                )
                                : FileContentWidget(
                                  fileContent:
                                      simulationState.simulationData ??
                                      FileContent(),

                                  searchQuery:
                                      context
                                          .watch<SearchQuestionCubit>()
                                          .state,

                                  onContentChanged:
                                      ({bool scrollToTop = false}) => {},
                                ),
                      ),

                      const SizedBox(height: 24),

                      if (totalQuestionsInExam > 0)
                        _buildPagination(
                          totalQuestionsInExam,
                          allQuestionsOnPage,
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
  }

  Widget _buildPagination(int totalInExam, List<Question> questionsOnPage) {
    if (_isSingleQuestionView && questionsOnPage.isNotEmpty) {
      final canGoToNextOnPage =
          _currentQuestionIndex < questionsOnPage.length - 1;

      final canGoToPrevOnPage = _currentQuestionIndex > 0;

      final canGoToNextPage = pageNumber * 10 < totalInExam;

      final canGoToPrevPage = pageNumber > 1;

      final absoluteQuestionNumber = questionsOnPage[_currentQuestionIndex].q;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(color: Colors.grey.shade200),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              'Question $absoluteQuestionNumber of $totalInExam',

              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              children: [
                IconButton(
                  splashRadius: 20,

                  onPressed:
                      (!canGoToPrevOnPage && !canGoToPrevPage)
                          ? null
                          : () {
                            if (canGoToPrevOnPage) {
                              setState(() => _currentQuestionIndex--);
                            } else {
                              setState(() {
                                pageNumber--;

                                _shouldGoToLastItemOnLoad = true;
                              });

                              fetchSimulationData();
                            }
                          },

                  icon: _buildPageButton(
                    Icons.arrow_back,

                    disabled: !canGoToPrevOnPage && !canGoToPrevPage,
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  splashRadius: 20,

                  onPressed:
                      (!canGoToNextOnPage && !canGoToNextPage)
                          ? null
                          : () {
                            if (canGoToNextOnPage) {
                              setState(() => _currentQuestionIndex++);
                            } else {
                              setState(() {
                                pageNumber++;

                                _currentQuestionIndex = 0;
                              });

                              fetchSimulationData();
                            }
                          },

                  icon: _buildPageButton(
                    Icons.arrow_forward,

                    disabled: !canGoToNextOnPage && !canGoToNextPage,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (!_isSingleQuestionView) {
      final canGoToNextPage = pageNumber * 10 < totalInExam;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(12),

          border: Border.all(color: Colors.grey.shade200),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text(
              'Showing page $pageNumber of ${(totalInExam / 10).ceil()}',

              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            Row(
              children: [
                IconButton(
                  splashRadius: 20,

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

                const SizedBox(width: 8),

                IconButton(
                  splashRadius: 20,

                  onPressed:
                      canGoToNextPage
                          ? () {
                            setState(() => pageNumber++);

                            fetchSimulationData();
                          }
                          : null,

                  icon: _buildPageButton(
                    Icons.arrow_forward,
                    disabled: !canGoToNextPage,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildHeader(
    BuildContext context,
    SimulationState state,
    bool isWide,
  ) {
    final fileName = state.simulationData?.fileName ?? '';

    final totalQuestions = state.totalItemLength ?? 0;

    final title = Flexible(
      // By giving the title a higher flex factor, it claims more available space.
      // The Spacer widget by default has a flex of 1.
      flex: 4,
      child: Tooltip(
        message: fileName,
        child: Text(
          fileName,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.headlineSmall?.copyWith(
            color: AppColors.themeBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final searchField = SizedBox(
      width: isWide ? 250 : double.infinity,

      child: TextFormField(
        onChanged: (v) => context.read<SearchQuestionCubit>().setQuery(v),

        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),

          hintText: 'Search in this file...',

          hintStyle: const TextStyle(color: Colors.grey),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.themePurple,
              width: 2,
            ),
          ),

          prefixIcon: const Icon(Icons.search, color: Colors.grey),
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

      borderRadius: 12,
    );

    final viewModeToggle = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(color: Colors.grey.shade200),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          const Text(
            "View:",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),

          const SizedBox(width: 4),

          Icon(
            Icons.list,
            color: !_isSingleQuestionView ? AppColors.themePurple : Colors.grey,
          ),

          Transform.scale(
            scale: 0.8,

            child: Switch(
              value: _isSingleQuestionView,

              onChanged:
                  (value) => setState(() {
                    _isSingleQuestionView = value;

                    _currentQuestionIndex = 0;
                  }),

              activeColor: AppColors.themePurple,
            ),
          ),

          Icon(
            Icons.filter_1,
            color: _isSingleQuestionView ? AppColors.themePurple : Colors.grey,
          ),
        ],
      ),
    );

    final goToButton = OutlinedButton.icon(
      onPressed: () => setState(() => _showGoToField = !_showGoToField),

      icon: Icon(
        Icons.find_in_page_outlined,
        size: 16,
        color: _showGoToField ? AppColors.themePurple : Colors.grey.shade600,
      ),

      label: Text(
        "Go To",
        style: TextStyle(
          color: Colors.grey.shade800,
          fontWeight: FontWeight.bold,
        ),
      ),

      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.grey.shade300),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          title,

          const Spacer(),

          viewModeToggle,

          const SizedBox(width: 16),

          goToButton,

          const SizedBox(width: 16),

          searchField,

          const SizedBox(width: 16),

          downloadButton,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        title,

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(child: searchField),

            const SizedBox(width: 8),

            goToButton,
          ],
        ),

        const SizedBox(height: 8),

        Align(alignment: Alignment.centerRight, child: viewModeToggle),

        const SizedBox(height: 16),

        Align(alignment: Alignment.centerRight, child: downloadButton),
      ],
    );
  }

  Widget _buildGoToField(int totalQuestions) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SizedBox(
            width: 150,

            child: TextField(
              controller: _goToController,

              autofocus: true,

              textAlign: TextAlign.center,

              keyboardType: TextInputType.number,

              inputFormatters: [FilteringTextInputFormatter.digitsOnly],

              decoration: InputDecoration(
                hintText: 'Go to...',

                isDense: true,

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              onSubmitted: (_) => _handleGoToQuestion(totalQuestions),
            ),
          ),

          const SizedBox(width: 8),

          ElevatedButton(
            onPressed: () => _handleGoToQuestion(totalQuestions),

            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themePurple,

              foregroundColor: Colors.white,
            ),

            child: const Text('Go'),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(IconData icon, {bool disabled = false}) => Icon(
    icon,

    size: 20,

    color: disabled ? Colors.grey.shade400 : AppColors.themePurple,
  );
}
