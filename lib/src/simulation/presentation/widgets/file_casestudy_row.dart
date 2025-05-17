import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_colors.dart' show AppColors;
import '../../../../core/res/asset.dart';
import '../../../../core/utils/size_utility.dart';
import '../../../../core/utils/spacer_utility.dart';
import '../../data/models/file_content_model.dart';
import 'asset_view.dart';
import 'package:readmore/readmore.dart';

import 'border_box.dart';

class FileCaseStudyRowWidget extends StatelessWidget {
  final CaseStudy caseStudy;

  const FileCaseStudyRowWidget({super.key, required this.caseStudy});

  @override
  Widget build(BuildContext context) {
    return BorderBox(
      margin: SpacerUtil.only(
        top: SpacerUtil.instance.small,
        left: caseStudy.hasTopic() ? SpacerUtil.instance.small : 0,
      ),
      child: Padding(
        padding: SpacerUtil.allPadding(SpacerUtil.instance.xxSmall),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: SpacerUtil.allPadding(SpacerUtil.instance.xSmall),
              child: AssetViewer(
                color: Color(0XFF145B58),
                size: SizeUtil.instance.standardIconSize,
                assetPath: Assets.caseStudy,
              ),
            ),
            SpacerUtil.horizontalSmall(),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(caseStudy.title, style: context.textTheme.titleSmall),
                  Text(
                    "Questions : ${caseStudy.questions?.length}",
                    style: context.textTheme.labelMedium,
                  ),

                  caseStudy.description.isEmpty || caseStudy.description == ""
                      ? Container()
                      : ReadMoreText(
                        caseStudy.description,
                        trimMode: TrimMode.Line,
                        trimLines: 5,
                        colorClickableText: AppColors.darkPrimary,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: '...Show less',
                        moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
