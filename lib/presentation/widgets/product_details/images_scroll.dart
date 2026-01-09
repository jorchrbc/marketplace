import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class ImagesScroll extends StatelessWidget {
  final List<Widget> cards;

  const ImagesScroll({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: cards.length,
      itemBuilder: (context, index){
        final card = cards[index];
        return card;
      }
    );
  }
}
