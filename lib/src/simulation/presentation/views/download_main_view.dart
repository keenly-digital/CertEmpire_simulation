import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/app_strings.dart';
import '../bloc/download_page_bloc/download_page_bloc.dart';
import 'download_table_view.dart';

class DownloadMainView extends StatefulWidget {
  const DownloadMainView({super.key});

  @override
  State<DownloadMainView> createState() => _DownloadMainViewState();
}

class _DownloadMainViewState extends State<DownloadMainView> {
  @override
  void initState() {
    super.initState();
    context.read<DownloadPageBloc>().add(
      GetDownloadsEvent(pageNumber: 1, pageSize: 10, userId: AppStrings.userId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            BlocBuilder<DownloadPageBloc, DownloadPageInitial>(
              builder: (context, state) {
                return Expanded(
                  child: DownloadTableView(download: state.orders ?? []),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
