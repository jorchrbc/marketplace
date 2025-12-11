import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget{
  final String hint;
  final Icon icon;
  const CustomTextFormField({required this.hint, required this.icon});
  Widget build(BuildContext context){
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        hintText: hint
      )
    );
  }
}