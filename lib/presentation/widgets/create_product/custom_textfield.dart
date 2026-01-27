import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int? mxlines;
  final int? mnlines;

  const CustomTextfield({
    super.key, 
    this.label, 
    this.hint, 
    this.errorMessage, 
    this.onChanged, 
    this.validator,
    this.controller,
    this.mnlines,
    this.mxlines,
    }
    );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;


    final border = OutlineInputBorder(
      //borderSide: BorderSide(color: col),
      borderRadius: BorderRadius.circular(50)
    );
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLines: mxlines,
      minLines: mnlines,

      validator: validator,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: Colors.red)),

        isDense: true,
        label: label != null ? Text(label!):null,
        hintText: hint,
        errorText: errorMessage,

      ),

    );
  }
}