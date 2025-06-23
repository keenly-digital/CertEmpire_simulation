
import 'package:flutter/material.dart';

import '../../../../../core/config/theme/app_colors.dart';

class DownloadHeader extends StatelessWidget {
  const DownloadHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: const Color(0x99EFEFEF),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Product",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text("File", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(
              "  Remaining",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "  Expires",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class DownloadRow extends StatelessWidget {
  final dynamic order; // Replace `dynamic` with your actual model

  const DownloadRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TableCell(flex: 2, text: order?.order ?? ''),
        _TableCell(text: order?.date ?? ''),
        _TableCell(text: order?.status ?? ''),
        _TableCell(text: order?.total ?? ''),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Wrap(
              spacing: 14,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              children: const [
                _DownloadButton(label: "Download"),
                _DownloadButton(label: "Practice Online"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TableCell extends StatelessWidget {
  final int flex;
  final String text;

  const _TableCell({this.flex = 1, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(text),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  final String label;

  const _DownloadButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Implement onTap handler
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.purple),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.purple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
