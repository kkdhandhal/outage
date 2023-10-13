// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class ShowLgnDialog extends StatelessWidget {
//   const ShowLgnDialog({
//     super.key,
//     required this.onClose,
//     required this.res_code,
//     required this.Dlg_title,
//     required this.msg,
//   });
//   final Function(int rtnCode) onClose;
//   final int res_code;
//   final String msg;
//   final String Dlg_title;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text("$res_code        $Dlg_title"),
//       content: Column(
//         children: [
//           //const CircularProgressIndicator(),
//           Text(msg),
//         ],
//       ),
//       actions: [
//         TextButton(
//           style: TextButton.styleFrom(
//             textStyle: Theme.of(context).textTheme.labelLarge,
//           ),
//           child: const Text('OK'),
//           onPressed: () {
//             onClose(0);
//           },
//         ),
//       ],
//     );
//   }
// }
