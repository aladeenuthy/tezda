import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final TextEditingController controller;
  const InputField(
      {Key? key,
      required this.labelText,
      required this.controller,
      this.initialValue,
      this.keyBoardType,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
  
      controller: controller,
      validator: validator,
      keyboardType: keyBoardType ?? TextInputType.text,
      obscureText: labelText == "Password" ? true : false,
      decoration: InputDecoration(
        label: Text(labelText),
      ),
    );
  }
}
