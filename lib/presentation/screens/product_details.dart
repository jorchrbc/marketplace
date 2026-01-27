import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/widgets/product_details/images_swiper.dart';
import 'package:marketplace/presentation/providers/product_details_provider.dart';

class ProductDetailsScreen extends StatefulWidget{
  final String id;
  const ProductDetailsScreen({required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>{
  
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        final provider = context.read<ProductDetailsProvider>();

        provider.clearAll();
        provider.getProductDetails(widget.id);
    });
  }

  @override
  void dispose(){
    context.read<ProductDetailsProvider>().clearAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final colors = Theme.of(context).colorScheme;
    final productDetailsProvider = Provider.of<ProductDetailsProvider>(context);

    if(productDetailsProvider.isLoading){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if(productDetailsProvider.errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Text(productDetailsProvider.errorMessage!)
        )
      );
    }
    
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 150, left: 15, right: 15),
          children:[
            SizedBox(
              height: 400,
              width: double.infinity,
              child: ProductSwiper(image_cards: productDetailsProvider.image_cards)
            ),

            Text(
              productDetailsProvider.name,
              style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 4),
            Text(
              productDetailsProvider.price,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 32),
            Text(productDetailsProvider.description,
              style: Theme.of(context).textTheme.bodyMedium
            ),
            SizedBox(height: 64),
            Text(
              productDetailsProvider.seller,
              style: Theme.of(context).textTheme.bodyLarge
            ),
          ]
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: 'add-cart',
                label: Text("Add to cart"),
                icon: Icon(Icons.shopping_cart),
                onPressed: (){}
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: 150,
              child: FloatingActionButton.extended(
                heroTag: 'buy-now',
                backgroundColor: colors.secondary,
                label: Text("Buy now", style: TextStyle(color: Colors.white)),
                icon: Icon(Icons.payment, color: Colors.white),
                onPressed: (){}
              ),
            )
          ]
        )
        ,
      )
    );
  }
}
