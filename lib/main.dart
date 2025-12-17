import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/config/router/app_router.dart';
import 'package:marketplace/presentation/providers/register_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'MarketPlace',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3EC6AF),
            primary: const Color(0xFF3EC6AF)
          ),
        ),
      ),
    );
  }
}