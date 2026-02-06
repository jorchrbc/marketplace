import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/profile_user/custom_dialog.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/user_profile_provider.dart';
import 'package:marketplace/presentation/widgets/profile_user/user_card.dart';
import 'package:go_router/go_router.dart';

class UserprofileScreen extends StatefulWidget{
  const UserprofileScreen({super.key});

  @override
  State<UserprofileScreen> createState() => _UserProfileScreenState();
}


class _UserProfileScreenState extends State<UserprofileScreen> {
  late UserProfileProvider _userProfileProvider;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    _userProfileProvider.clearAll();
    _userProfileProvider.getUserInfo();
    });
 
  }
  
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _userProfileProvider = context.read<UserProfileProvider>();
  }


  @override
  void dispose(){
    _userProfileProvider.clearAll();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userprofileprovider = Provider.of<UserProfileProvider>(context);
    
    if(userprofileprovider.isLoading){
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if(userprofileprovider.errorMessage != null){
      return Scaffold(
        body: Center(
          child: Text(userprofileprovider.errorMessage!),
        ),
      );
    }

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
              title: 'Nombre',
              subtitle: '${userprofileprovider.name} ${userprofileprovider.lastName}',
              
            ),
            SizedBox(height: 5),
            CustomCard(
              icon: Icons.phone_android_outlined,
              title: 'Telefono',
              subtitle: userprofileprovider.phone,
            ),
            SizedBox(height: 5),

            CustomCard(icon: Icons.email_outlined, title: 'Correo', subtitle: userprofileprovider.email),
            SizedBox(height: 5),

            ElevatedButton(onPressed: (){
              CustomDialog(userprofileprovider.phone, '${userprofileprovider.name} ${userprofileprovider.lastName}');
            }, 
            child: Text('Editar')
            ),

            // SizedBox(height: 5),

            // Row(
            //   children: [
            //     CustomCard(icon: Icons.shopping_bag_outlined, title: 'Pedidos', subtitle: '',
            //       onTap: () { 
            //         context.push('/home');
            //       }
            //     ),
            //     CustomCard(icon: Icons.list_alt_rounded, title: 'Productos', subtitle: '',
            //       onTap: (){
            //         context.push('/home');
            //     },)
            //   ],
            // ),
            // SizedBox(height: 50),

            // CustomCard(icon: Icons.mode_edit_outline_outlined, title: 'Editar información', subtitle: '',
            //   onTap: (){
            //     CustomDialog(userprofileprovider.phone, '${userprofileprovider.name} ${userprofileprovider.lastName}');
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
