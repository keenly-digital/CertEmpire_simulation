import 'dart:html' as html;
import 'package:certempiree/core/config/extensions/theme_extension.dart';
import 'package:certempiree/core/config/theme/font_manager.dart';
import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:certempiree/src/simulation/presentation/bloc/download_page_bloc/download_page_bloc.dart';
import 'package:certempiree/src/simulation/presentation/bloc/simulation_bloc/simulation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../data/models/download_model.dart';
import '../bloc/simulation_bloc/simulation_event.dart';

class DownloadTableView extends StatefulWidget {
  final List<DownloadedData>? download;
  const DownloadTableView({super.key, required this.download});

  @override
  State<DownloadTableView> createState() => _DownloadTableViewState();
}

class _DownloadTableViewState extends State<DownloadTableView> {
  int? _menuRowIndex;
  bool _showFullScreenLoader = false;
  List<GlobalKey> _downloadBtnKeys = [];
  OverlayEntry? _menuOverlayEntry;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final count = widget.download?.length ?? 0;
    _downloadBtnKeys = List.generate(count, (_) => GlobalKey());
    _hideMenu();
  }

  void _showMenuForRow(int rowIndex, DownloadedData item) {
    _hideMenu(); // Remove any previous menu
    final key = _downloadBtnKeys[rowIndex];
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    _menuRowIndex = rowIndex;

    _menuOverlayEntry = OverlayEntry(
      builder:
          (context) => GestureDetector(
            // Click outside closes
            onTap: _hideMenu,
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                Positioned(
                  left: offset.dx,
                  top: offset.dy + size.height + 7,
                  child: Material(
                    elevation: 12,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pointer/caret
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            width: 18,
                            height: 10,
                            child: CustomPaint(
                              painter: _CaretPainter(
                                color: Colors.white,
                                shadow: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 188,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26.withOpacity(0.08),
                                blurRadius: 14,
                                offset: Offset(0, 5),
                              ),
                            ],
                            border: Border.all(
                              color: Colors.black12,
                              width: 0.6,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {
                                  _hideMenu();
                                  _download(item, rowIndex, "pdf");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 13,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        size: 21,
                                        color: AppColors.themeBlue,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(child: Text("Download as .pdf")),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(height: 0),
                              InkWell(
                                onTap: () {
                                  _hideMenu();
                                  _download(item, rowIndex, "qzs");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 13,
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.insert_drive_file,
                                        size: 21,
                                        color: Colors.teal,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(child: Text("Download as .qzs")),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
    Overlay.of(context, rootOverlay: true).insert(_menuOverlayEntry!);
  }

  void _hideMenu() {
    _menuOverlayEntry?.remove();
    _menuOverlayEntry = null;
    _menuRowIndex = null;
  }

  Future<void> _download(
    DownloadedData item,
    int rowIndex,
    String format,
  ) async {
    setState(() {
      _showFullScreenLoader = true;
    });

    try {
      await context.read<DownloadPageBloc>().exportFile(
        item.fileId ?? "",
        format: format,
        forceDownload: true,
        fileName: _downloadFileName(item, format),
      );
    } catch (e) {
      // Optionally handle errors here
    } finally {
      if (mounted) setState(() => _showFullScreenLoader = false);
    }
  }

  String _downloadFileName(DownloadedData item, String format) {
    String base = (item.downloadName ?? item.productName ?? "file")
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '_');
    if (!base.endsWith('.$format')) base += '.$format';
    return base;
  }

  @override
  void dispose() {
    _hideMenu();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final double contentMaxWidth = 1200.0;

    EdgeInsets containerPadding = EdgeInsets.symmetric(
      horizontal: isMobile ? 8.w : (isTablet ? 18.w : 32.w).clampDouble(10, 36),
      vertical: isMobile ? 10.h : 20.h.clamp(10.0, 32.0),
    );

    final downloads = widget.download ?? [];
    if (_downloadBtnKeys.length != downloads.length) {
      _downloadBtnKeys = List.generate(downloads.length, (_) => GlobalKey());
    }

    Widget mainContent;
    if (downloads.isEmpty) {
      mainContent = Padding(
        padding: containerPadding,
        child: Center(
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 14.w : 22.w),
                child: Text(
                  "No downloads available.",
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: (isMobile ? 15.sp : 17.sp).clampDouble(14, 22),
                    fontWeight: FontManager.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      mainContent = Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: contentMaxWidth),
          child: Padding(
            padding: containerPadding,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.r),
              ),
              margin: EdgeInsets.only(bottom: 16.h),
              color: Colors.white,
              shadowColor: Colors.grey.withOpacity(0.10),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: (isMobile ? 8.w : 24.w).clampDouble(8, 30),
                  vertical: (isMobile ? 10.h : 20.h).clampDouble(10, 28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Downloads",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: AppColors.themeBlue,
                        fontWeight: FontManager.bold,
                        letterSpacing: 0.1,
                        fontSize: (isMobile ? 16.sp : 18.sp).clampDouble(
                          15,
                          26,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (isMobile ? 14.h : 22.h).clampDouble(12, 32),
                    ),
                    if (isMobile)
                      ...downloads.asMap().entries.map((entry) {
                        final i = entry.key;
                        final item = entry.value;
                        return _DownloadMobileCard(
                          item: item,
                          onDownload: () => _showMenuForRow(i, item),
                          menuOpen: _menuRowIndex == i,
                          onMenuOption: (String format) {
                            _hideMenu();
                            _download(item, i, format);
                          },
                          buttonKey: _downloadBtnKeys[i],
                        );
                      }).toList()
                    else
                      Builder(
                        builder: (ctx) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 900,
                                maxWidth: contentMaxWidth - 2 * 24.w,
                              ),
                              child: DataTable(
                                headingRowColor: MaterialStateProperty.all(
                                  const Color(0xFFF4F6FB),
                                ),
                                headingTextStyle: context.textTheme.labelLarge
                                    ?.copyWith(
                                      color: AppColors.themeBlue,
                                      fontWeight: FontManager.bold,
                                      fontSize: 15.5.sp.clampDouble(14, 18),
                                    ),
                                dataRowMinHeight: (isTablet ? 52.h : 56.h)
                                    .clampDouble(36, 62),
                                dataRowMaxHeight: (isTablet ? 56.h : 62.h)
                                    .clampDouble(40, 70),
                                columns: const [
                                  DataColumn(label: Text('Product')),
                                  DataColumn(label: Text('File')),
                                  DataColumn(label: Text('Remaining')),
                                  DataColumn(label: Text('Expires')),
                                  DataColumn(label: Text('Actions')),
                                ],
                                rows:
                                    downloads.asMap().entries.map((entry) {
                                      final i = entry.key;
                                      final item = entry.value;
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text(item.productName ?? ""),
                                          ),
                                          DataCell(
                                            Text(item.downloadName ?? ""),
                                          ),
                                          DataCell(
                                            Text(item.downloadsRemaining ?? ""),
                                          ),
                                          DataCell(
                                            Text(
                                              convertDate(
                                                item.accessExpires ?? "",
                                              ),
                                            ),
                                          ),
                                          DataCell(
                                            Row(
                                              children: [
                                                Container(
                                                  key: _downloadBtnKeys[i],
                                                  child: _ModernActionBtn(
                                                    label: "Download",
                                                    icon:
                                                        Icons.download_rounded,
                                                    color: AppColors.themeBlue,
                                                    onTap:
                                                        () => _showMenuForRow(
                                                          i,
                                                          item,
                                                        ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                _ModernActionBtn(
                                                  label: "Practice",
                                                  icon:
                                                      Icons
                                                          .play_circle_fill_rounded,
                                                  color: Colors.green[700]!,
                                                  onTap: () {
                                                    if (item.fileId?.isEmpty ??
                                                        true) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "File ID is not available.",
                                                          ),
                                                        ),
                                                      );
                                                      return;
                                                    }
                                                    AppStrings.fileId =
                                                        item.fileId ?? "";
                                                    context
                                                        .read<SimulationBloc>()
                                                        .add(
                                                          FetchSimulationDataEvent(
                                                            fieldId:
                                                                item.fileId ??
                                                                "",
                                                            pageNumber: 1,
                                                          ),
                                                        );
                                                    context.go(
                                                      "/Downloads/Simulation",
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Stack(
      children: [
        mainContent,
        if (_showFullScreenLoader)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.22),
              alignment: Alignment.center,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 30.h.clampDouble(18, 56),
                    horizontal: 32.w.clampDouble(18, 64),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(19.r),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 32),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColors.themeBlue),
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Preparing your download...",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8.sp,
                        ),
                      ),
                      SizedBox(height: 10),
                      IconButton(
                        onPressed:
                            () => setState(() => _showFullScreenLoader = false),
                        icon: Icon(
                          Icons.close_rounded,
                          color: Colors.black54,
                          size: 30,
                        ),
                        tooltip: "Cancel",
                        splashRadius: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  String convertDate(String isoTimestamp) {
    try {
      final dateTime = DateTime.parse(isoTimestamp);
      return DateFormat('MMMM d, yyyy').format(dateTime);
    } catch (_) {
      return 'Never';
    }
  }
}

// Fancy caret/pointer for the menu popup
class _CaretPainter extends CustomPainter {
  final Color color;
  final Color shadow;
  _CaretPainter({required this.color, required this.shadow});
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, shadow, 3, true);
    final paint = Paint()..color = color;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Download options menu widget
class _DownloadMenu extends StatelessWidget {
  final void Function(String format) onOptionSelected;
  final VoidCallback close;

  const _DownloadMenu({required this.onOptionSelected, required this.close});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 170,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () {
                onOptionSelected("pdf");
                close();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text("Download as .pdf"),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                onOptionSelected("qzs");
                close();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text("Download as .qzs"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool enabled;
  const _ModernActionBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return TextButton.icon(
      icon: Icon(
        icon,
        size: (isMobile ? 17.sp : 18.sp).clampDouble(14, 20),
        color: enabled ? color : color.withOpacity(0.5),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: enabled ? color : color.withOpacity(0.5),
          fontWeight: FontManager.bold,
          fontSize: (isMobile ? 13.5.sp : 14.5.sp).clampDouble(12, 16),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: color.withOpacity(enabled ? 0.09 : 0.03),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        minimumSize: Size(
          (isMobile ? 45.w : 60.w).clampDouble(40, 90),
          40.h.clampDouble(34, 44),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: (isMobile ? 8.w : 10.w).clampDouble(6, 16),
          vertical: (isMobile ? 5.h : 6.h).clampDouble(4, 10),
        ),
      ),
      onPressed: enabled ? onTap : null,
    );
  }
}

class _DownloadMobileCard extends StatelessWidget {
  final DownloadedData item;
  final VoidCallback onDownload;
  final bool menuOpen;
  final void Function(String format) onMenuOption;
  final GlobalKey buttonKey;

  const _DownloadMobileCard({
    required this.item,
    required this.onDownload,
    required this.menuOpen,
    required this.onMenuOption,
    required this.buttonKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: EdgeInsets.only(bottom: 14.h),
          elevation: 1.3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w.clampDouble(8, 22)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName ?? "—",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontManager.bold,
                    fontSize: 16.sp.clampDouble(14, 19),
                  ),
                ),
                SizedBox(height: 8.h.clampDouble(6, 12)),
                _dlRow(theme.textTheme, "File", item.downloadName ?? "—"),
                _dlRow(
                  theme.textTheme,
                  "Remaining",
                  item.downloadsRemaining ?? "—",
                ),
                _dlRow(
                  theme.textTheme,
                  "Expires",
                  _tryDate(item.accessExpires),
                ),
                SizedBox(height: 10.h.clampDouble(8, 18)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        key: buttonKey,
                        child: _ModernActionBtn(
                          label: "Download",
                          icon: Icons.download_rounded,
                          color: AppColors.themeBlue,
                          onTap: onDownload,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w.clampDouble(6, 18)),
                    Expanded(
                      child: _ModernActionBtn(
                        label: "Practice",
                        icon: Icons.play_circle_fill_rounded,
                        color: Colors.green[700]!,
                        onTap: () {
                          if (item.fileId?.isEmpty ?? true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("File ID is not available."),
                              ),
                            );
                            return;
                          }
                          AppStrings.fileId = item.fileId ?? "";
                          context.read<SimulationBloc>().add(
                            FetchSimulationDataEvent(
                              fieldId: item.fileId ?? "",
                              pageNumber: 1,
                            ),
                          );
                          context.go("/Downloads/Simulation");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (menuOpen)
          Positioned(
            top: 60,
            right: 0,
            child: _DownloadMenu(onOptionSelected: onMenuOption, close: () {}),
          ),
      ],
    );
  }

  Widget _dlRow(TextTheme theme, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          SizedBox(
            width: 85.w.clampDouble(60, 110),
            child: Text(
              "$label:",
              style: theme.bodyMedium?.copyWith(
                fontWeight: FontManager.semiBold,
                fontSize: 13.5.sp.clampDouble(12, 15),
                color: AppColors.themeBlue,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.bodySmall?.copyWith(
                fontSize: 13.sp.clampDouble(12, 14.5),
                fontWeight: FontManager.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _tryDate(String? iso) {
    if (iso == null) return "Never";
    try {
      return DateFormat('MMMM d, yyyy').format(DateTime.parse(iso));
    } catch (_) {
      return "Never";
    }
  }
}

// Utility extension for double clamping
extension ClampDouble on double {
  double clampDouble(double min, double max) =>
      this < min ? min : (this > max ? max : this);
}
