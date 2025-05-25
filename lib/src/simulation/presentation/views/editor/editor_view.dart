import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

import '../../../../../core/utils/editor_util.dart';

class EditorView extends StatefulWidget {
  final String? initialContent;
  final QuillController? quillController;
  final Color? textColor;

  const EditorView({
    super.key,
    this.initialContent,
    this.quillController,
    this.textColor,
  });

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  late QuillController _controller;
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();

  bool get isReadOnly => widget.quillController == null;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    final cleanedContent = cleanNewLines(widget.initialContent ?? "");
    final originalDelta = Delta.fromJson(parseStringToDeltaJson(cleanedContent));

    _controller =
        widget.quillController ??
            QuillController(
              readOnly: true,
              document: Document.fromDelta(
                _applyTextColorToDelta(originalDelta, widget.textColor),
              ),
              selection: const TextSelection.collapsed(offset: 0),
            );
  }

  @override
  void didUpdateWidget(covariant EditorView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialContent != oldWidget.initialContent ||
        widget.textColor != oldWidget.textColor) {
      if (widget.quillController == null) {
        _controller.dispose();
        _initializeController();
        setState(() {});
      }
    }
  }

  Delta _applyTextColorToDelta(Delta delta, Color? color) {
    if (color == null) return delta;

    final colorHex =
    '#${color.value.toRadixString(16).substring(2)}'.toLowerCase();
    final newDelta = Delta();

    for (var op in delta.toList()) {
      if (op.isInsert) {
        final attrs = Map<String, dynamic>.from(op.attributes ?? {});
        attrs['color'] = colorHex;
        newDelta.insert(op.data, attrs);
      } else {
        newDelta.push(op);
      }
    }

    return newDelta;
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isReadOnly,
      child: QuillEditor(
        controller: _controller,
        focusNode: isReadOnly ? FocusNode() : _editorFocusNode,
        scrollController: _editorScrollController,
        config: QuillEditorConfig(
          placeholder: isReadOnly ? "" : 'Start writing...',
          embedBuilders: [
            ...FlutterQuillEmbeds.editorBuilders(
              imageEmbedConfig: QuillEditorImageEmbedConfig(
                imageProviderBuilder: (context, imageUrl) {
                  if (imageUrl.startsWith('assets/')) {
                    return AssetImage(imageUrl);
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (widget.quillController == null) {
      _controller.dispose();
    }
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
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
          buffer.write('\n'); // Keep \n only if directly before a valid match
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
