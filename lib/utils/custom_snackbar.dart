import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ScaffoldMessenger showSnackbar(BuildContext context, String text) {
  return ScaffoldMessenger(child: SnackBar(content: Text(text)));
}

Future<void> showToast(BuildContext context, String text) async {
  await Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0);
}
