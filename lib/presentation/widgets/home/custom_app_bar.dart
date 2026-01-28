import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Size preferredSize;
  final VoidCallback logout;
  final VoidCallback goCart;
  const CustomAppBar({Key? key, required this.logout, required this.goCart})
    : preferredSize = const Size.fromHeight(kToolbarHeight),
    super(key: key);

  Widget build(BuildContext context){
    return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 2.0),
        child: PopupMenuButton<int>(
          icon: CircleAvatar(
            backgroundImage: AssetImage('assets/profile.png')
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text('Mi perfil')
            ),
            PopupMenuItem(
              value: 2,
              child: Text('Cerrar sesión')
            ),
          ],
          onSelected: (value){
            if(value == 1){
              context.push('/user-profile');
            }
            if(value == 2){
              logout();
              context.go('/');
            }
          }
        )
      ),
      title: const Text("Mi cuenta"),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart_sharp),
            onPressed: () {
              goCart();
            },
          ),
        )
      ],
    );
  }
}
