import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/screens/product_form.dart';
import 'package:marketplace/presentation/screens/screens.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const ProductRegist(),

    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
   /* GoRoute(
      path: '/product_form',
      name: 'ProductForm',
      builder: (context, state) => const MyHomePage(title: 'Flutter Demo Home Page'),
    ),
    */
  ]
);