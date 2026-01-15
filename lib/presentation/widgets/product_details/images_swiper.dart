import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class ProductSwiper extends StatelessWidget{
  final List<Widget> image_cards;

  const ProductSwiper({super.key, required this.image_cards});
  @override
  Widget build(BuildContext context){
    final colors = Theme.of(context).colorScheme;
    return Swiper(
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: SwiperPagination(
        margin: const EdgeInsets.only(top: 20.0),
        builder: DotSwiperPaginationBuilder(
          activeColor: colors.primary,
          color: colors.secondary,
          size: 8.0,
          activeSize: 10
        )
      ),
      itemCount: image_cards.length,
      itemBuilder: (context, index){
        final image_card = image_cards[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: image_card);
      }
    );
  }
}
