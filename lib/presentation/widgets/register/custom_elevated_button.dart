import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget{
  final VoidCallback? onPressed;
  final String? text;
  final Color? color;
  CustomElevatedButton({this.onPressed, this.text, this.color});
  
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )
        ),
        child: Text(
          text ?? 'Testing',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          )
        )
      ),
    );
  }
}