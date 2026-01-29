import 'package:flutter/material.dart';
import 'package:marketplace/presentation/providers/login_provider.dart';
import 'package:marketplace/presentation/widgets/profile_user/user_card.dart';
import 'package:marketplace/presentation/widgets/register/custom_elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/config/router/app_router.dart';


class UserprofileScreen extends StatelessWidget {
  const UserprofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //ProfileHeader(),
            CustomCard(
              icon: Icons.person,
              title: 'Usuario',
              subtitle: 'data',
              
            ),
            SizedBox(height: 5),
            CustomCard(
              icon: Icons.phone_android_outlined,
              title: 'Telefono',
              subtitle: '+52 492 890 9901',
              onTap: (){
                context.push('/create-product');
              },
            ),
            SizedBox(height: 5),

            CustomCard(icon: Icons.email_outlined, title: 'Correo', subtitle: 'Correo@correo.com'),
            SizedBox(height: 5),

            CustomCard(icon: Icons.fmd_good_outlined, title: 'Pedidos', subtitle: 'pedidos'),

            SizedBox(height: 5),
            
            CustomCard(icon: Icons.shop, title: 'Ventas', subtitle: 'subtitle'),
            SizedBox(height: 240),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
              child: InkWell(
                onTap: (){
                  context.push('/create-product');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45,vertical: 5),
                  child: Text('product'),
                ),
              ),
            ),
            SizedBox(height: 5),

            Row(
              children: [
                CustomCard(icon: Icons.shopping_bag_outlined, title: 'Pedidos', subtitle: '',
                onTap: () { 
                  context.push('/home');
                  }
                ),
                CustomCard(icon: Icons.list_alt_rounded, title: 'Productos', subtitle: '',
                onTap: (){
                  context.push('/home');
                },)
              ],
            ),

            CustomCard(icon: Icons.logout_outlined, title: 'Cerrar sesión', subtitle: '',
            onTap: () async{
             // final logoutProvider = context.read<LoginProvider>();
            })
          ],
        ),
      ),
    );
  }
}
