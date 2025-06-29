import 'package:flutter/material.dart';

import '../../data/models/file_content_model.dart';
import '../widgets/admin_question_overview.dart';
import '../widgets/file_casestudy_row.dart';
import '../widgets/file_topic_row.dart'; // FIX: This import was missing

typedef ContentChanged = void Function({bool scrollToTop});

/// Renders file content items and notifies parent when inner content size changes.
class FileContentWidget extends StatelessWidget {
  final FileContent fileContent;
  final String searchQuery;
  final ContentChanged onContentChanged;

  const FileContentWidget({
    Key? key,
    required this.fileContent,
    this.searchQuery = '',
    required this.onContentChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flatItems =
        _flattenItems(
          fileContent.items,
        ).where((item) => _matchesSearch(item, searchQuery)).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(flatItems.length, (index) {
        final flatItem = flatItems[index];
        return flatItem.item.when(
          question:
              (question) => AdminQuestionOverviewWidget(
                key: ValueKey('q_${question.id}'), // <-- ADD KEY
                question: question,
                questionIndex: question.q,
                onContentChanged: onContentChanged,
              ),
          topic:
              (topic) => FileTopicRowWidget(
                key: ValueKey('t_${topic.title}'), // <-- ADD KEY
                topic: topic,
              ),
          caseStudy:
              (caseStudy) => FileCaseStudyRowWidget(
                key: ValueKey('cs_${caseStudy.title}'), // <-- ADD KEY
                caseStudy: caseStudy,
              ),
        );
      }),
    );
  }

  bool _matchesSearch(FlatItem item, String query) {
    if (query.isEmpty) return true;
    return item.item.when(
      question:
          (q) => q.questionText.toLowerCase().contains(query.toLowerCase()),
      topic: (_) => true,
      caseStudy: (_) => true,
    );
  }

  List<FlatItem> _flattenItems(List<CommonItem> items, [int level = 0]) {
    final List<FlatItem> flatList = [];
    for (final item in items) {
      flatList.add(FlatItem(item: item, level: level));
      item.when(
        question: (_) {},
        topic: (topic) {
          flatList.addAll(_flattenItems(topic.topicItems ?? [], level + 1));
        },
        caseStudy: (caseStudy) {
          final questions = caseStudy.questions ?? [];
          flatList.addAll(
            _flattenItems(
              questions.map((q) => CommonItem.question(q)).toList(),
              level + 1,
            ),
          );
        },
      );
    }
    return flatList;
  }
}

/// Wrapper for flattened items
class FlatItem {
  final CommonItem item;
  final int level;
  FlatItem({required this.item, required this.level});
}
