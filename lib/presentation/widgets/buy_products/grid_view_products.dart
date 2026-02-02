import 'package:flutter/material.dart';
import 'package:marketplace/domain/entities/details.dart';
import 'item.dart';

class GridViewProductsToBuy extends StatelessWidget{
  final List productsToBuy;
  final void Function(String productId) goProductDetails;
  final void Function(String productId, int quantity) addProduct;
  final VoidCallback goCart;
  final ScrollController scrollController;
  
  const GridViewProductsToBuy(
    {
      required this.productsToBuy,
      required this.goProductDetails,
      required this.goCart,
      required this.addProduct,
      required this.scrollController
    }
  );

  Widget build(BuildContext context){
    return GridView.builder(
      controller: scrollController,
      itemCount: productsToBuy.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index){
        final item = productsToBuy[index];
        return Item(
          goProductDetails: goProductDetails,
          addProduct: addProduct,
          goCart: goCart,
          text: item.name,
          price: "\$${item.price}",
          image: item.imagePath,
          id: item.id
        );
      }
    );
  }
}
