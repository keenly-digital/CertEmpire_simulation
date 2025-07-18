import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/src/simulation/presentation/views/editor/editor_view.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../../core/utils/editor_util.dart';

import '../../../../core/config/theme/app_colors.dart' show AppColors;
import '../../../../core/res/asset.dart';
import '../../../../core/utils/spacer_utility.dart';
import '../../data/models/file_content_model.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, top: 5),
              child: Image.asset(Assets.caseStudy, width: 22, height: 22),
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
                      :ExpandableQuillViewer(jsonContent: caseStudy.description,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ExpandableQuillViewer extends StatefulWidget {
  final String? jsonContent; // Raw input content

  const ExpandableQuillViewer({super.key, required this.jsonContent});

  @override
  State<ExpandableQuillViewer> createState() => _ExpandableQuillViewerState();
}

class _ExpandableQuillViewerState extends State<ExpandableQuillViewer> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cleanedContent = cleanNewLines(widget.jsonContent ?? '');
    final doc = Document.fromJson(parseStringToDeltaJson(cleanedContent));
    final controller = QuillController(
      document: doc,
      readOnly: true,
      selection: const TextSelection.collapsed(offset: 0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _expanded ? null : 150,
          child: ClipRect(
            child: QuillEditor(
              controller: controller,
              focusNode: FocusNode(),
              scrollController: ScrollController(),
              config: QuillEditorConfig(
                scrollable: false,
                placeholder: '',
                embedBuilders: FlutterQuillEmbeds.editorBuilders(),
                showCursor: false,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => _expanded = !_expanded),
          child: Text(_expanded ? 'Show less' : 'Show more'),
        ),
      ],
    );
  }

  /// Removes all \n except those that are directly followed by an image or link
  String cleanNewLines(String input) {
    final buffer = StringBuffer();
    final regex = RegExp(
      r"^(<img\s+src='.*?'>|https?:\/\/\S+\.(jpg|png)|https?:\/\/\S+)",
      caseSensitive: false,
    );

    int i = 0;
    while (i < input.length) {
      if (input[i] == '\n') {
        final remaining = input.substring(i + 1);
        final match = regex.firstMatch(remaining);
        if (match != null && match.start == 0) {
          buffer.write('\n'); // Keep \n only if followed by image/link
        }
        // else skip this \n
      } else {
        buffer.write(input[i]);
      }
      i++;
    }

    return buffer.toString();
  }
}

