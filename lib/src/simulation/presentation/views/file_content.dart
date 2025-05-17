import 'package:flutter/cupertino.dart';

import '../../data/models/file_content_model.dart';
import '../widgets/admin_file_question_item_row.dart';
import '../widgets/file_casestudy_row.dart';
import '../widgets/file_topic_row.dart';

class FileContentWidget extends StatelessWidget {
  final FileContent fileContent;

  const FileContentWidget({super.key, required this.fileContent});

  @override
  Widget build(BuildContext context) {
    final flatItems = _flattenItems(fileContent.items);
    return ListView.builder(
      itemCount: flatItems.length,
      itemBuilder: (context, index) {
        var flatItem = flatItems[index];

        return flatItem.item.when(
          question:
              (question) => AdminFileQuestionItemRow(
                question: question,
                questionIndex: question.q,
              ),
          topic: (topic) => FileTopicRowWidget(topic: topic),
          caseStudy:
              (caseStudy) => FileCaseStudyRowWidget(caseStudy: caseStudy),
        );
      },
    );
  }

  List<FlatItem> _flattenItems(List<CommonItem> items, [int level = 0]) {
    List<FlatItem> flatList = [];

    for (var item in items) {
      flatList.add(FlatItem(item: item, level: level));
      item.when(
        question: (_) => {},
        topic: (topic) {
          flatList.addAll(_flattenItems(topic.topicItems ?? [], level + 1));
        },
        caseStudy: (caseStudy) {
          flatList.addAll(
            _flattenItems(
              caseStudy.questions!.map((q) => CommonItem.question(q)).toList(),
              level + 1,
            ),
          );
        },
      );
    }

    return flatList;
  }
}

class FlatItem {
  final CommonItem item;
  final int level;

  FlatItem({required this.item, required this.level});
}
