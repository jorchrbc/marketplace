import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/product_details_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    final productDetailsProvider = Provider.of<ProductDetailsProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Pantalla Principal")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMkAxWY4CUFGxZo0Cbrq24uMTUIViorzA8Pg&s"),
            SizedBox(height: 10),
            TextButton(
              child: Text("Crear producto"),
              onPressed: (){
                context.goNamed('create-product');
              }
            ),
            TextButton(
              child: Text("Product details"),
              onPressed: (){
                productDetailsProvider.getProductDetails();
                context.goNamed('product-details');
              }
            ),
          ]
        ),
      ),
    );
      
  }
}
