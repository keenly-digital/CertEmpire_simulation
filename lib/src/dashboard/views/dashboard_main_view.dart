import 'package:certempiree/core/res/asset.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/res/app_strings.dart';
import '../presentation/bloc/user_bloc/user_events.dart';

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
    return Align(
      alignment: Alignment.topLeft,
      child: Image.asset(Assets.submittion),
    );
  }
}
