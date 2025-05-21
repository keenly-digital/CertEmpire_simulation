import 'package:certempiree/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CommonHelper {
  static showToast({String? message}) {
    Fluttertoast.showToast(
      msg: message ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showLoader(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.purple),
                SizedBox(width: 16.w),
                Text("Please wait...", style: TextStyle(fontSize: 16.sp)),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoader(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
