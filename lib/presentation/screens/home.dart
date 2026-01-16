import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pantalla Principal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              context.push('/cart');
            },
          ),
        ],
      ),
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
          ]
        ),
      ),
    );
      
  }
}
