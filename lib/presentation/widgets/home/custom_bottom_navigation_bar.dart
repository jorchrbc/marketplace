import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigationBar extends StatelessWidget{
  final int currentIndex;
  
  const CustomBottomNavigationBar({
      super.key,
      required this.currentIndex
  });
  
  @override
  Widget build(BuildContext context){
    final location = GoRouterState.of(context).uri.toString();
    
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
              context.go('/home/0');
              break;
            case 1:
              context.go('/home/1');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Comprar'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Vender'
          ),
        ]
      )
    );
  }
}
