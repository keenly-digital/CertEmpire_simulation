import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReportIncorrectAnswerDialog extends StatelessWidget {
  const ReportIncorrectAnswerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.red, width: 1.5.w),
        borderRadius: BorderRadius.circular(10.r),
      ),
      insetPadding: EdgeInsets.all(16.w),
      child: SizedBox(
        height: ScreenUtil().screenHeight * 0.8,
        width: ScreenUtil().screenWidth * 0.75,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Report Answer As Incorrect",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                "Choose The Option That You Believe Is Right One:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              SizedBox(height: 10.h),
              _buildOption(
                "A",
                "Install the AWS Load Balancer Controller for Kubernetes. Using that controller, configure a Network Load Balancer with a TCP listener on port 443 to forward traffic to the IP addresses of the backend service Pods.",
              ),
              _buildOption(
                "B",
                "Install the AWS Load Balancer Controller for Kubernetes. Using that controller, configure an Application Load Balancer with an HTTPS listener on port 443 to forward traffic to the IP addresses of the backend service Pods.",
              ),
              _buildOption(
                "C",
                "Create a target group. Add the EKS managed node group’s Auto Scaling group as a target. Create an Application Load Balancer with an HTTPS listener on port 443 to forward traffic to the target group.",
                highlight: true,
              ),
              _buildOption(
                "D",
                "Create a target group. Add the EKS managed node group’s Auto Scaling group as a target. Create a Network Load Balancer with a TLS listener on port 443 to forward traffic to the target group.",
              ),
              SizedBox(height: 20.h),
              Text(
                "Why Do You Think That Your Suggestion Is Right\nAnd Our Selected Answer Was Wrong?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                "Write An Explanation To This Selection.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              SizedBox(height: 8.h),
              TextField(
                maxLines: 6,
                decoration: InputDecoration(
                   hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: SizedBox(
                  width: 150.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red, width: 1.5.w),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pop(); // You can trigger any action here
                    },
                    child: Text("SUBMIT", style: TextStyle(fontSize: 14.sp)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOption(String label, String text, {bool highlight = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 12.sp, color: Colors.black),
          children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: text,
              style: TextStyle(color: highlight ? Colors.green : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
