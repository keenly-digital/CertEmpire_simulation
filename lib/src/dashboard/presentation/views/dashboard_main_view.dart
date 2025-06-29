import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/app_strings.dart';
import '../bloc/user_bloc/user_events.dart';

class UserMainView extends StatefulWidget {
  const UserMainView({super.key});

  @override
  State<UserMainView> createState() => _UserMainViewState();
}

class _UserMainViewState extends State<UserMainView> {
  @override
  void initState() {
    context.read<UserBloc>().add(GetUserEvent(userId: AppStrings.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String userName = AppStrings.name;
    final String lastStudiedFile =
        "MB-330: Microsoft Dynamics 365 Supply Chain Management";
    final int questionsAnswered = 35;
    final int totalQuestions = 150;

    // FIX #1: The entire page Column is wrapped in a SingleChildScrollView.
    // This makes the dashboard vertically scrollable and fixes all bottom overflows.
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeHeader(userName),
          const SizedBox(height: 24.0),
          LayoutBuilder(
            builder: (context, constraints) {
              // Your responsive logic for web/mobile is great and remains unchanged.
              if (constraints.maxWidth > 950) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          _buildContinueStudyingCard(
                            context,
                            fileName: lastStudiedFile,
                            answered: questionsAnswered,
                            total: totalQuestions,
                          ),
                          const SizedBox(height: 24),
                          _buildSummarySection(context),
                        ],
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 585,
                        child: _buildUpdatesFeed(context),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContinueStudyingCard(
                      context,
                      fileName: lastStudiedFile,
                      answered: questionsAnswered,
                      total: totalQuestions,
                    ),
                    const SizedBox(height: 24.0),
                    _buildUpdatesFeed(context),
                    const SizedBox(height: 24.0),
                    _buildSummarySection(context),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(String userName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        'Welcome back, $userName',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildContinueStudyingCard(
    BuildContext context, {
    required String fileName,
    required int answered,
    required int total,
  }) {
    double progress = total > 0 ? answered / total : 0;

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [AppColors.themeBlue, const Color(0xFF3A5FCD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONTINUE WHERE YOU LEFT OFF',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            fileName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '$answered/$total',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed:
                () => context.read<NavigationCubit>().selectTab(2, subTitle: 1),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.themeBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text(
              'Continue Studying',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdatesFeed(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Updates & Notifications',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _updateTile(
            icon: Icons.task_alt,
            iconColor: Colors.green,
            title: 'New Task Assigned',
            subtitle: 'Review "AZ-104" feedback',
            isUnread: true,
          ),
          const Divider(height: 24),
          _updateTile(
            icon: Icons.email_outlined,
            iconColor: Colors.blue,
            title: 'Password Reset Successful',
            subtitle: 'Your password was changed',
          ),
          const Divider(height: 24),
          _updateTile(
            icon: Icons.flag_outlined,
            iconColor: Colors.red,
            title: 'Report #452 Resolved',
            subtitle: 'Your report has been addressed',
          ),
        ],
      ),
    );
  }

  Widget _updateTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool isUnread = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ),
        ),
        if (isUnread)
          Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: AppColors.themeBlue,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 2.2,
      children: [
        _summaryCard(
          context: context,
          icon: Icons.emoji_events_outlined,
          title: 'My Rewards',
          value: '2,500 Pts',
          color: Colors.amber,
          onTap: () => context.read<NavigationCubit>().selectTab(5),
        ),
        _summaryCard(
          context: context,
          icon: Icons.checklist_rtl_outlined,
          title: 'Pending Tasks',
          value: '3 Tasks',
          color: Colors.red,
          onTap: () => context.read<NavigationCubit>().selectTab(3),
        ),
        _summaryCard(
          context: context,
          icon: Icons.flag_outlined,
          title: 'Open Reports',
          value: '1 Report',
          color: Colors.orange,
          onTap: () => context.read<NavigationCubit>().selectTab(4),
        ),
        _summaryCard(
          context: context,
          icon: Icons.shopping_bag_outlined,
          title: 'Recent Purchase',
          value: 'DP-203',
          color: Colors.blue,
          onTap: () => context.read<NavigationCubit>().selectTab(1),
        ),
      ],
    );
  }

  Widget _summaryCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // FIX #2: Wrapped the Text widget in Expanded.
                // This tells the text to take up the available flexible space
                // and prevents it from pushing the icon out of bounds.
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    // Adding an overflow handler is good practice.
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Icon(icon, color: color, size: 28),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
