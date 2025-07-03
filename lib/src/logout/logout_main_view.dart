import 'dart:html' as html;
import 'package:certempiree/core/res/app_strings.dart';
import 'package:flutter/material.dart';

class LogoutMainView extends StatefulWidget {
  const LogoutMainView({super.key});

  @override
  State<LogoutMainView> createState() => _LogoutMainViewState();
}

class _LogoutMainViewState extends State<LogoutMainView> {
  @override
  void initState() {
    super.initState();
    // Redirect immediately on widget load
    html.window.location.href =
        "${AppStrings.baseUrl}/my-account/?action=logout";
  }

  @override
  Widget build(BuildContext context) {
    // Optionally show a spinner or message for a split second
    return Align(alignment: Alignment.topCenter);
  }
}
