 import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/home_provider.dart';
import 'package:marketplace/presentation/providers/cart_provider.dart';
import 'package:marketplace/presentation/widgets/home/home_widgets.dart';
import 'package:marketplace/presentation/views/views.dart';

class HomeScreen extends StatelessWidget{
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({
      super.key,
      required this.pageIndex
  });

  final viewRoutes = const <Widget>[
    BuyProductsView(),
    VendorProductsView(),
  ];
  
  @override
  Widget build(BuildContext context){
    final homeProvider = Provider.of<HomeProvider>(context);
    
    return Scaffold(
      appBar: CustomAppBar(
        logout: () async{
          await homeProvider.logoutUser();
          if(homeProvider.errorMessage != null){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(homeProvider.errorMessage!)),
            );
          }
          context.go('/');
        },
        goCart: () {
          context.push('/cart');
        },
        goUserProfile: (){
          context.push('/user-profile');
        }
      ),
      body: Stack(
        children: [
          IndexedStack(
            index: pageIndex,
            children: viewRoutes,
          ),
          if(homeProvider.isLoading)
            Container(
              child: const Center(child: CircularProgressIndicator()),
            )
        ]
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
