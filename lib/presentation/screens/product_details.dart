import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/product_details/product_details_widgets.dart';

final List<Widget> cards = [
  Card(
    child: Image.network("https://upload.wikimedia.org/wikipedia/en/5/56/Age_of_Empires_II_-_The_Age_of_Kings_Coverart.png")
  ),
  Card(
    child: Image.network("https://upload.wikimedia.org/wikipedia/en/5/56/Age_of_Empires_II_-_The_Age_of_Kings_Coverart.png")
  ),
];

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),

          Text(
            "Age of Empires II: The Best Game",
            style: textStyles.titleLarge,
          ),

          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: ImagesScroll(cards: cards),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: size.width - 40,
            child: Text(
              "\$20",
              style: textStyles.titleLarge,
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: size.width - 40,
            child: Text(
              "Age of Empires is a series of historical real-time strategy video games, originally developed by Ensemble Studios and published by Xbox Game Studios.",
              style: textStyles.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

