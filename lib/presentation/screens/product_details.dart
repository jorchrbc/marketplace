import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget{
  const ProductDetailsScreen();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.network("https://upload.wikimedia.org/wikipedia/en/5/56/Age_of_Empires_II_-_The_Age_of_Kings_Coverart.png"
            )
          ),
          Text("Age of Empires II: The Best Game"),
        ]
      )
    );
  }
}
