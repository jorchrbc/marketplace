import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/home_provider.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/presentation/widgets/home/home_widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    if(homeProvider.errorMessage != null){
      return Scaffold(
        body: Center(
          child: Text(homeProvider.errorMessage!)
        )
      );
    }
    
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(
        logout: () async{
          try{
            await homeProvider.logoutUser();
            context.go('/');
          } catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error en la conexión')),
            );
          }
        },
        goCart: () {
          context.push('/cart');
        }
      ),
      body: GridViewProductsToBuy(
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
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        goHome: (){
          context.go('/');
        },
        goProfile: (){
          context.push('/cart');
        }
      )
    );
  }
}
