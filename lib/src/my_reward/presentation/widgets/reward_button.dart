import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RewardButton extends StatelessWidget {
  final String? txt;
  final void Function()? onPressed;
  final Color? borderColor;
  final Color? txtColor;


  const RewardButton({super.key, this.txt, this.onPressed, this.borderColor,this.txtColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          onPressed ??
          () {
            Navigator.pop(context, txt);
          },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? AppColors.purple),
        ),
      ),
      child: Text(
        txt ?? "",
        style: TextStyle(fontSize: 10.sp, color: txtColor ??AppColors.purple),
      ),
    );
  }
}
