import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final ValueChanged<String> onChanged;
  final String? errorText;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.icon,
    required this.onChanged,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        icon: icon,
        hintText: hint,
        helperText: ' ',
        errorText: errorText
      ),
    );
  }
}
