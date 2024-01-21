import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;

  final Function(String)? onChanged;
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.obscureText,
    this.onChanged,
    this.initialValue,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  static InputDecoration myInputDecoration({
    String? labelText,
    String? hintText,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
