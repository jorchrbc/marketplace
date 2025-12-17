import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Icon icon;
  final ValueChanged<String> onChanged;
  final String? Function(String?) validator;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.icon,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        icon: icon,
        hintText: hint,
      ),
    );
  }
}
