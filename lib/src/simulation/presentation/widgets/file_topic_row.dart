import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/config/theme/app_colors.dart';
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
                BorderBox(
                  width: 20.w,
                  height: 20.h,
                  child: Image.asset(Assets.topic),
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
