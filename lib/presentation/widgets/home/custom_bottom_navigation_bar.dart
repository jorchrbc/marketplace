import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigationBar extends StatelessWidget{
  final VoidCallback goHome;
  final VoidCallback goProfile;
  const CustomBottomNavigationBar({required this.goHome, required this.goProfile});

  int _locationToIndex(String location){
    if(location.startsWith('/profile')) return 1;
    return 0;
  }
  
  @override
  Widget build(BuildContext context){
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);
    
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.elliptical(50,20),
      ),
      child: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: currentIndex,
        onTap: (index){
          switch(index){
            case 0:
              goHome();
              break;
            case 1:
              goProfile();
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Comprar'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil'
          ),
        ]
      )
    );
  }
}
