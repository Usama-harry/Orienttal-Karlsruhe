import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isDigitOnly;
  final bool isObsecure;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.isDigitOnly = false,
    this.isObsecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObsecure,
      inputFormatters:
          isDigitOnly ? [FilteringTextInputFormatter.digitsOnly] : [],
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
