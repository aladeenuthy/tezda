
import 'package:flutter/material.dart';

import '../helpers/key_helper.dart';
import 'constants.dart';

void showLoadingSpinner() {
  AlertDialog alert = const AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(color: primaryColor),
        SizedBox(width: 10),
        Text("Loading"),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: KeyHelper.appNavKey.currentContext!,
    builder: (context) {
      return alert;
    },
  );
}



void showSnackBar(String message, [bool error = true]) {
  KeyHelper.scafKey.currentState!.showSnackBar(SnackBar(
    duration: const Duration(seconds: 1),
    content: Text(message),
    backgroundColor: error ? Colors.redAccent : Colors.greenAccent,
  ));
}
  String capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1)}';
  }
Widget inputField(String hintText, String? Function(String?) validator,
    TextEditingController? controller,
    {TextInputType inputType = TextInputType.text, bool obscureText = false}) {
  return TextFormField(
    validator: validator,
    keyboardType: inputType,
    obscureText: obscureText,
    decoration: InputDecoration(
      label: Text(hintText),
    ),
  );
}
