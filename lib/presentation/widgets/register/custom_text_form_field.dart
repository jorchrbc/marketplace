import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget{
  final String hint;
  final Icon icon;
  final TextEditingController controller;
  final String? Function(String?) validator;
  
  const CustomTextFormField({
      required this.hint,
      required this.icon,
      required this.controller,
      required this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormField();
}

class _CustomTextFormField extends State<CustomTextFormField>{

  @override
  void dispose(){
    widget.controller.dispose();
    super.dispose();
  }
  Widget build(BuildContext context){
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        icon: widget.icon,
        hintText: widget.hint
      )
    );
  }
}