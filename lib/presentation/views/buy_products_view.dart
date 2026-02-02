import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/buy_products_provider.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/presentation/widgets/buy_products/buy_products_widgets.dart';

class BuyProductsView extends StatefulWidget {
  const BuyProductsView({super.key});

  @override
  State<BuyProductsView> createState() => _BuyProductsViewState();
}

class _BuyProductsViewState extends State<BuyProductsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<BuyProductsProvider>().getProductsToBuy();
    });
  }
  
  @override
  Widget build(BuildContext context){
    final buyProductsProvider = context.watch<BuyProductsProvider>();
    final cartProvider = context.read<CartProvider>();

    if(buyProductsProvider.isLoading){
      return Center(child: CircularProgressIndicator());
    }
    
    if(buyProductsProvider.errorMessage != null){
      print(buyProductsProvider.errorMessage);
      return Center(
          child: Text(buyProductsProvider.errorMessage!)
        );
    }
    
    if(buyProductsProvider.productsToBuy.isEmpty){
      return Center(child: Text('No hay productos para mostrar.'));
    }
    return GridViewProductsToBuy(
      productsToBuy: buyProductsProvider.productsToBuy,
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
