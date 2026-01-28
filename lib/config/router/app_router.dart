import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      //builder: (context, state) => const ProductForm(),
      builder: (context, state) => const LoginScreen(),

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
      path: '/vendor-products',
      name: 'vendor-products',
      builder: (context, state) => const VendorProductsScreen(),
    ),
    GoRoute(
      path: '/checkout',
      name: 'checkout',
      builder: (context, state) => const ProcederPagoScreen(),
    ),
  ]
);
