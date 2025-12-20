import 'package:flutter/material.dart';
import 'package:marketplace/presentation/providers/login_provider.dart';
import 'package:provider/provider.dart';

import 'package:marketplace/domain/repositories/auth_repository.dart';
import 'package:marketplace/infrastructure/datasources/auth_datasource_impl.dart';
import 'package:marketplace/infrastructure/repositories/auth_repository_impl.dart';
import 'package:marketplace/presentation/providers/register_provider.dart';
import 'package:marketplace/config/router/app_router.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(datasource: AuthDatasourceImpl()),
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