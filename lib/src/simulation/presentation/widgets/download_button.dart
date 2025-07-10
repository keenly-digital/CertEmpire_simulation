import 'dart:typed_data';
import 'dart:html' as html;
import 'package:certempiree/core/res/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DownloadActionBtn extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const DownloadActionBtn({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  State<DownloadActionBtn> createState() => DownloadActionBtnState();
}

class DownloadActionBtnState extends State<DownloadActionBtn> {
  bool _loading = false;

  Future<void> _showLoader() async {
    setState(() => _loading = true);
    showDialog(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  void _hideLoader() {
    setState(() => _loading = false);
    if (mounted && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> _exportAndDownloadFile(String fileId, String type) async {
    await _showLoader();
    final apiUrl = '${AppStrings.netbaseUrl}Quiz/GetFileDownloadUrl';
    try {
      final dio = Dio();
      final response = await dio.get(
        apiUrl,
        queryParameters: {'fileId': fileId, 'fileType': type},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (!mounted) return;

      if (response.data['Success'] == true && response.data['Data'] != null) {
        final downloadUrl = response.data['Data'] as String;
        final fileName = Uri.parse(downloadUrl).pathSegments.last;
        await _triggerWebDownload(downloadUrl, fileName);
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Download started: $fileName')));
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.data['Message'] ?? "Download failed"),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      if (mounted) _hideLoader();
    }
  }

  Future<void> _triggerWebDownload(String url, String filename) async {
    final dio = Dio();
    final response = await dio.get<List<int>>(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    final bytes = response.data;
    if (bytes == null) {
      throw Exception('Failed to download file: No data received.');
    }
    final data = Uint8List.fromList(bytes);
    final blob = html.Blob([data]);
    final objectUrl = html.Url.createObjectUrlFromBlob(blob);

    final anchor =
        html.AnchorElement(href: objectUrl)
          ..download = filename
          ..style.display = 'none';

    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    html.Url.revokeObjectUrl(objectUrl);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.label == "Download") {
      return PopupMenuButton<String>(
        offset: const Offset(0, 40),
        tooltip: widget.label,
        onSelected: (value) async {
          final fileId = AppStrings.fileId;
          if (fileId.isEmpty) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('No file selected!')));
            return;
          }
          if (value == 'pdf' || value == 'qzs') {
            await _exportAndDownloadFile(fileId, value);
          }
        },
        itemBuilder:
            (context) => const [
              PopupMenuItem(value: 'pdf', child: Text('Download as PDF')),
              PopupMenuItem(value: 'qzs', child: Text('Download as QZS')),
            ],
        child: TextButton.icon(
          icon: Icon(widget.icon, size: 18, color: widget.color),
          label: Text(
            widget.label,
            style: TextStyle(
              color: widget.color,
              fontWeight: FontWeight.bold,
              fontSize: 14.5,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: widget.color.withOpacity(0.09),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(45, 40),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          ),
          onPressed: null,
        ),
      );
    }
    return TextButton.icon(
      icon: Icon(widget.icon, size: 18, color: widget.color),
      label: Text(
        widget.label,
        style: TextStyle(
          color: widget.color,
          fontWeight: FontWeight.bold,
          fontSize: 14.5,
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: widget.color.withOpacity(0.09),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size(45, 40),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      onPressed: widget.onTap,
    );
  }
}
