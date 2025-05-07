
import 'package:flutter/material.dart';



class Snackbar {
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // static show(String message, {bool barrierDismissible = false}) {
  //   // Dismiss any current SnackBars before showing a new one
  //   scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
  //
  //   // Show the new SnackBar with custom styles
  //   scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
  //     dismissDirection: DismissDirection.startToEnd,
  //     content: SnackbarWidget(
  //         messenger: scaffoldMessengerKey.currentState!, message: message),
  //     backgroundColor: Colors.transparent,
  //     elevation: 0.0,
  //     behavior: SnackBarBehavior.floating,
  //     duration: Duration(seconds: 3),
  //   ));
  // }
}

// class SnackbarWidget extends StatelessWidget {
//   const SnackbarWidget({
//     super.key,
//     required this.message,
//     required this.messenger,
//   });
//
//   final String message;
//   final ScaffoldMessengerState messenger;
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.center,
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Flexible(
//             child: Container(
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Color(0xFFEFFDFF),
//                         Color(0xFFFFFFFF),
//                       ]),
//                   border: Border.all(color: AppColors.dialogBorder, width: 1),
//                   borderRadius: BorderRadius.circular(14)),
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Flexible(
//                     child: LabelText(
//                       text: message,
//                       style: context.textTheme.titleMedium,
//                     ),
//                   ),
//                   SpacerUtil.horizontalMedium(),
//                   IconButton(
//                     icon: const Icon(Icons.close),
//                     tooltip: 'Close',
//                     visualDensity: VisualDensity.compact,
//                     onPressed: messenger.hideCurrentSnackBar,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

