import 'package:flutter/material.dart';

Widget appButton({
  required void Function()? onPressed,
  String? text,
  Color? background,
  Color? borderColor,
  Color? textColor,
  bool? withIcon,
  double borderRadius = 8.0,
}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      backgroundColor: background,
      side: BorderSide(
        color: borderColor ?? Colors.black,

      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius), // ⬅️ Apply here
      ),
    ),
    child: Row(
      children: [
        withIcon == true
            ? Icon(Icons.download, color: Colors.white)
            : SizedBox.shrink(),
        Text(text ?? "", style: TextStyle(color: textColor ?? Colors.black)),
      ],
    ),
  );
}
