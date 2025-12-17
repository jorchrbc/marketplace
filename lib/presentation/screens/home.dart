import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/register/roledialog.dart';

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
      appBar: AppBar(title: const Text("Pantalla Principal")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await showRadioOptionDialog(
              context: context,
              title: "Selecciona un rol",
              option1: "Comprador",
              option2: "Vendedor",
            );

            if (result != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Elegiste: $result")),
              );
            }
          },
          child: const Text("Seleccionar un rol"),
        ),
      ),
    );
      
  }
}
