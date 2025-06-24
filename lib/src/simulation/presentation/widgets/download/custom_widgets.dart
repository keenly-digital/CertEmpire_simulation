import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/config/theme/app_colors.dart';
import '../../../data/models/download_model.dart';

class DownloadHeader extends StatelessWidget {
  const DownloadHeader({super.key});

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
  final DownloadModel order; // Replace `dynamic` with your actual model

  const DownloadRow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TableCell(flex: 2, text: order.productName.toString() ?? ''),
        _TableCell(text: order.file?.name ?? ''),
        _TableCell(text: order.downloadsRemaining ?? ''),
        _TableCell(text: convertDate(order.accessExpires ?? '')),
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
              children: [
                _DownloadButton(
                  label: "Download",
                  onTap: () async {
                    await launchUrl(
                      Uri.parse(
                        "https://certempirbackend-production.up.railway.app/uploads/QuizFiles/MB-330_Dumps_Export.pdf",
                      ),
                    );
                  },
                ),

                _DownloadButton(label: "Practice Online", onTap: () {
                  
                  
                  context.read<NavigationCubit>().selectTab(2,subTitle: 1);
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (_) {
      return '';
    }
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
  void Function()? onTap;

  _DownloadButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
