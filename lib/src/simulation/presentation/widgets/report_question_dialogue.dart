import 'package:certempiree/core/res/app_strings.dart';
import 'package:certempiree/src/simulation/presentation/widgets/thank_you_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportQuestionDialog extends StatefulWidget {
  const ReportQuestionDialog({super.key});

  @override
  _ReportQuestionDialogState createState() => _ReportQuestionDialogState();
}

class _ReportQuestionDialogState extends State<ReportQuestionDialog> {
  String? _selectedReason;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red, width: 1.5.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SizedBox(
        width: ScreenUtil().screenWidth * 0.7,
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.reportQue,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    decoration: TextDecoration.underline,
                  decorationColor: Colors.red),
                ),
                SizedBox(height: 15.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppStrings.chooseCriteria,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3, // Increase scale as needed
                      child: Radio<String>(
                        value: 'Outdated',
                        groupValue: _selectedReason,
                        onChanged: (val) => setState(() => _selectedReason = val),
                      ),
                    ),
                    Text(
                      'Question is Outdated',
                      style: TextStyle(fontSize: 7.sp),
                    ),
                    SizedBox(width: 10.w),
                    Transform.scale(
                      scale: 1.3, // Match scale of the first radio
                      child: Radio<String>(
                        value: 'Framed Wrong',
                        groupValue: _selectedReason,
                        onChanged: (val) => setState(() => _selectedReason = val),
                      ),
                    ),
                    Text(
                      'Question is framed wrong',
                      style: TextStyle(fontSize: 7.sp),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Write An Explanation To This Report. *',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(3.w),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red, width: 1.5.w),
                      foregroundColor: Colors.red,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ThankYouDialogue(),
                      );
                    },
                    child: Text('SUBMIT', style: TextStyle(fontSize: 14.sp)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
