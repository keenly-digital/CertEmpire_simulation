import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:certempiree/src/dashboard/presentation/bloc/user_bloc/user_events.dart';
import 'package:certempiree/core/res/app_strings.dart';

class AppBootstrapper extends StatefulWidget {
  final Widget child;
  const AppBootstrapper({required this.child, super.key});

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    final uri = Uri.base;
    final encodedData = uri.queryParameters['auth_token'];
    if (encodedData != null) {
      try {
        final decodedJson = utf8.decode(base64Url.decode(encodedData));
        final Map<String, dynamic> data = jsonDecode(decodedJson);
        AppStrings.id = data['id'] ?? '10860';
        AppStrings.userId = data['simulation_user_id'];
        AppStrings.authToken = encodedData;
        AppStrings.name = data['name'] ?? 'Guest';
      } catch (e) {
        debugPrint("Error decoding data: $e");
      }
    }
    // Now, always dispatch this event to UserBloc
    context.read<UserBloc>().add(GetUserEvent(userId: AppStrings.id));
    setState(() => initialized = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return widget.child;
  }
}
