import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      //builder: (context, state) => const UserprofileScreen(),
      //builder: (context, state) => const ProductForm(),
      builder: (context, state) => const LoginScreen(),

    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home/:page',
      name: 'home',
      builder: (context, state){
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
    ),
    GoRoute(
      path: '/create-product',
      name: 'create-product',
      builder: (context, state) => const ProductForm(),
    ),
    GoRoute(
      path: '/product-details/:id',
      name: 'product-details',
      builder: (context, state){
        final id = state.pathParameters['id']!;
        return ProductDetailsScreen(id: id);
      },
    ),
    GoRoute(
      path: '/cart',
      name: 'cart',
      builder: (context, state) => const CarritoComprasScreen(),
    ),
    GoRoute(
      path: '/user-profile',
      name: 'user-profile',
      builder: (context, state) => const UserprofileScreen(),
      ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const ProcederPagoScreen(),
    ),
  ]
);
