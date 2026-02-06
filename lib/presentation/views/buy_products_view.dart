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
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    final provider = context.read<BuyProductsProvider>();

    _scrollController = ScrollController();
    _scrollController.addListener((){
        if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200){
          if(!provider.isFetchingMore && provider.hasMore){
            provider.getProductsToBuy(nextPage: true);
          }
        }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<BuyProductsProvider>().getProductsToBuy();
    });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    final buyProductsProvider = context.watch<BuyProductsProvider>();
    final cartProvider = context.read<CartProvider>();

    if(buyProductsProvider.isInitialLoading && buyProductsProvider.productsToBuy.isEmpty){
      return Center(child: CircularProgressIndicator());
    }
    
    if(buyProductsProvider.errorMessage != null){
      print(buyProductsProvider.errorMessage);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 80,
              color: Colors.grey
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (){
                context.read<BuyProductsProvider>().getProductsToBuy();
              },
              child: const Text('Reintentar')
            )
          ]
        )
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
      },
      scrollController: _scrollController,
    );
  }
}
