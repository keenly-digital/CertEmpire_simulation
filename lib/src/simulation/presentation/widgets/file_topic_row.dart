import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/asset.dart';
import '../../../../core/utils/spacer_utility.dart';
import '../../data/models/file_content_model.dart';
import 'border_box.dart';

class FileTopicRowWidget extends StatelessWidget {
  final Topic topic;

  const FileTopicRowWidget({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      margin: SpacerUtil.only(top: SpacerUtil.instance.small),
      child: Padding(
        padding: SpacerUtil.allPadding(SpacerUtil.instance.xxSmall),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5),
                  child: Image.asset(
                    Assets.topic,
                    width: 22,
                    height: 22,
                    color: Colors.black,
                  ),
                ),

                SpacerUtil.horizontalSmall(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(topic.title, style: context.textTheme.titleSmall),
                    Row(
                      children: [
                        Text(
                          "Case Studies : ${topic.getCaseStudyCount()}",
                          style: context.textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
