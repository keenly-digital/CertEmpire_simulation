import 'package:flutter/material.dart';

import '../../../../core/utils/spacer_utility.dart';
import '../../data/models/question_model.dart';
import 'admin_question_overview.dart';
import 'border_box.dart';

class AdminFileQuestionItemRow extends StatelessWidget {
  const AdminFileQuestionItemRow({
    super.key,
    required this.questionIndex,
    required this.question,
  });

  final int questionIndex;
  final Question question;


  @override
  Widget build(BuildContext context) {
    return BorderBox(
      margin: SpacerUtil.only(
        top: SpacerUtil.instance.small,
        left: calculateLeftMargin(),
      ),
      padding: SpacerUtil.allPadding(SpacerUtil.instance.xxSmall),
      child: AdminQuestionOverviewWidget(
        question: question,
        questionIndex: questionIndex,
      ),
    );
  }

  double calculateLeftMargin() {
    if (question.hasTopic() && question.hasCaseStudy()) {
      return SpacerUtil.instance.large;
    } else if (question.hasTopic()) {
      return SpacerUtil.instance.medium;
    } else if (question.hasCaseStudy()) {
      return SpacerUtil.instance.medium;
    } else {
      return 0;
    }
  }
}
