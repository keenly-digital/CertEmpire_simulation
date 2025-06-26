import 'package:certempiree/core/res/asset.dart';
import 'package:flutter/material.dart';

class SubmittionMainView extends StatelessWidget {
  const SubmittionMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Image.asset(Assets.submittion),
    );
  }
}
