import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/home_provider.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/presentation/widgets/home/home_widgets.dart';

class BuyProductsView extends StatefulWidget {
  const BuyProductsView({super.key});

  @override
  State<BuyProductsView> createState() => _BuyProductsViewState();
}

class _BuyProductsViewState extends State<BuyProductsView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getProductsToBuy();
  }
  
  @override
  Widget build(BuildContext context){
    final homeProvider = Provider.of<HomeProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    if(homeProvider.isLoading){
      return Center(child: CircularProgressIndicator());
    }
    if(homeProvider.errorMessage != null){
      print(homeProvider.errorMessage);
      return Center(
          child: Text(homeProvider.errorMessage!)
        );
    }
    return GridViewProductsToBuy(
      productsToBuy: homeProvider.productsToBuy,
      addProduct: cartProvider.addItem,
      goProductDetails: (String productId){
        context.push(
          '/product-details/$productId'
        );
      },
      goCart: (){
        context.push('/cart');
      }
    );
  }
}
