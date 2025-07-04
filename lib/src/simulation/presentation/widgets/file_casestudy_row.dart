import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../core/res/asset.dart';
import '../../../../core/utils/editor_util.dart';
import '../../data/models/file_content_model.dart';

class FileCaseStudyRowWidget extends StatefulWidget {
  final CaseStudy caseStudy;
  final bool initiallyExpanded;

  const FileCaseStudyRowWidget({
    super.key,
    required this.caseStudy,
    this.initiallyExpanded = false,
  });

  @override
  State<FileCaseStudyRowWidget> createState() => _FileCaseStudyRowWidgetState();
}

class _FileCaseStudyRowWidgetState extends State<FileCaseStudyRowWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Widget _buildLabel(String text) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        color: Colors.grey.shade500,
        fontWeight: FontWeight.bold,
        fontSize: 12,
        letterSpacing: 0.8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      padding: const EdgeInsets.all(26.0),
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundpurple.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.themePurple.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- REFACTORED: Added LayoutBuilder for a responsive header ---
          LayoutBuilder(
            builder: (context, constraints) {
              // On screens wider than 500px, use the original Row layout.
              if (constraints.maxWidth > 500) {
                return _buildWideHeader();
              } else {
                // On narrower screens, use a Column-based layout to prevent overflow.
                return _buildNarrowHeader();
              }
            },
          ),
          if (widget.caseStudy.description.isNotEmpty) ...[
            const Divider(height: 32),
            ExpandableQuillViewer(
              jsonContent: widget.caseStudy.description,
              isExpanded: _isExpanded,
            ),
          ],
        ],
      ),
    );
  }

  /// Header layout for wide screens.
  Widget _buildWideHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          Assets.caseStudy,
          width: 24,
          height: 24,
          color: AppColors.themePurple,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Case Study"),
              const SizedBox(height: 4),
              Text(
                widget.caseStudy.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.themePurple,
                ),
              ),
            ],
          ),
        ),
        Text(
          "Questions: ${widget.caseStudy.questions?.length ?? 0}",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(width: 16),
        TextButton(
          onPressed: () => setState(() => _isExpanded = !_isExpanded),
          child: Row(
            children: [
              Text(
                _isExpanded ? "Hide" : "Show",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Header layout for narrow screens to prevent overflow.
  Widget _buildNarrowHeader() {
    return Column(
      children: [
        // Top row for the icon and title
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.caseStudy,
              width: 24,
              height: 24,
              color: AppColors.themePurple,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Case Study"),
                  const SizedBox(height: 4),
                  Text(
                    widget.caseStudy.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.themePurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Bottom row for the questions count and button, aligned to the right
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Questions: ${widget.caseStudy.questions?.length ?? 0}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
              child: Row(
                children: [
                  Text(
                    _isExpanded ? "Hide" : "Show",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// This widget does not require any changes.
class ExpandableQuillViewer extends StatelessWidget {
  final String? jsonContent;
  final bool isExpanded;

  const ExpandableQuillViewer({
    super.key,
    required this.jsonContent,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final doc = Document.fromJson(parseStringToDeltaJson(jsonContent ?? ''));
    final controller = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
      readOnly: true,
    );
    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 300),
      firstChild: SizedBox(
        height: 50,
        child: ClipRect(
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(
              padding: EdgeInsets.zero,
              showCursor: false,
              embedBuilders: FlutterQuillEmbeds.editorBuilders(),
            ),
          ),
        ),
      ),
      secondChild: QuillEditor.basic(
        controller: controller,
        config: QuillEditorConfig(
          padding: EdgeInsets.zero,
          showCursor: false,
          embedBuilders: FlutterQuillEmbeds.editorBuilders(),
        ),
      ),
      crossFadeState:
          isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }
}
