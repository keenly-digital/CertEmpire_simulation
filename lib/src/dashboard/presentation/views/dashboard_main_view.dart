import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_state.dart';
import 'package:certempiree/src/main/presentation/bloc/navigation_cubit.dart';
import 'package:flutter/gestures.dart';
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
    return BlocBuilder<UserBloc, UserInitialState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: 'Hello '),
                  TextSpan(
                    text: state.userData?.firstName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '(not ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextSpan(
                    text: state.userData?.firstName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '? '),
                  TextSpan(
                    text: 'Log out',
                    style: TextStyle(color: AppColors.themeBlue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            // html.window.location.href =
                            //     "${AppStrings.baseUrl}/?action=logout";
                          },
                  ),
                  TextSpan(text: ')'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'From your account dashboard you can view your ',
                  ),
                  TextSpan(
                    text: 'recent orders',
                    style: TextStyle(color: AppColors.themeBlue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.read<NavigationCubit>().selectTab(1);
                          },
                  ),
                  TextSpan(text: ', manage your '),
                  TextSpan(
                    text: 'shipping and billing addresses',
                    style: TextStyle(color: AppColors.themeBlue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.read<NavigationCubit>().selectTab(
                              6,
                              subTitle: 0,
                            );
                          },
                  ),
                  TextSpan(text: ', and '),
                  TextSpan(
                    text: 'edit your password and account details',
                    style: TextStyle(color: AppColors.themeBlue),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () {
                            context.read<NavigationCubit>().selectTab(8);
                          },
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
