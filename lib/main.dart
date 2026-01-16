import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:marketplace/config/router/app_router.dart';

import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/repositories/cart_repository.dart';

import 'package:marketplace/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:marketplace/infrastructure/datasources/products_datasource_impl.dart';
import 'package:marketplace/infrastructure/services/token_storage_impl.dart';

import 'package:marketplace/infrastructure/repositories/auth_repository_impl.dart';
import 'package:marketplace/infrastructure/repositories/products_repository_impl.dart';

import 'package:marketplace/infrastructure/datasources/cart_datasource_impl.dart';
import 'package:marketplace/infrastructure/repositories/cart_repository_impl.dart';
import 'package:marketplace/presentation/providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final tokenStorage = TokenStorageImpl();
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            datasource: AuthDatasourceImpl(), tokenStorage: tokenStorage
          ),
        ),
        Provider<ProductsRepository>(
          create: (_) => ProductsRepositoryImpl(datasource: ProductsDatasourceImpl(
          tokenStorage: tokenStorage)),
        ),
        Provider<CartRepository>(
           create: (_) => CartRepositoryImpl(
             datasource: CartDatasourceImpl(tokenStorage: tokenStorage)
           )
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginProvider(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateProductProvider(
            productsRepository: context.read<ProductsRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductDetailsProvider(
            productsRepository: context.read<ProductsRepository>(),
        )
        ChangeNotifierProvider(
          create: (context) => CartProvider(
            cartRepository: context.read<CartRepository>()
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        title: 'MarketPlace',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3EC6AF),
            primary: const Color(0xFF3EC6AF),
            inversePrimary: const Color(0xFF2563EB)
          ),
        ),
      ),
    );
  }
}
