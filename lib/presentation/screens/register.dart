import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/providers/register_provider.dart';
import 'package:marketplace/presentation/widgets/register/register_widgets.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: _RegisterView()
      ),
    );
  }
}

class _RegisterView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        children: [
          Text(
            'Crear cuenta',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40
            )
          ),
          SizedBox(height: 20),
          _RegisterForm()
        ]
      )
    );
  }
}

class _RegisterForm extends StatefulWidget{
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm>{

  @override
  Widget build(BuildContext context){
    final registerProvider = Provider.of<RegisterProvider>(context);
    return Form(
      key: registerProvider.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            hint: 'Nombre',
            icon: Icon(Icons.person_outlined),
            onChanged: (value){
              registerProvider.name = value;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Ingresar nombre';
              if(!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) return 'Solo se permiten letras';
              return null;
            },
          ),
          CustomTextFormField(
            hint: 'Apellidos',
            icon: Icon(Icons.person),
            onChanged: (value){
              registerProvider.lastName = value;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Ingresar apellidos';
              if(!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) return 'Solo se permiten letras';
              return null;
            },
          ),
          CustomTextFormField(
            hint: 'Teléfono',
            icon: Icon(Icons.phone_outlined),
            onChanged: (value){
              registerProvider.phone = value;
            },
            validator: (value) {
              if(value == null || value.trim().isEmpty) return 'Ingresar teléfono';
              final cleanedValue = value.replaceAll(RegExp(r'[\s-]'), '');
              if(!RegExp(r'^(\+52|52|0)?(1)?[1-9][0-9]{9}$').hasMatch(cleanedValue)) return 'Ingresa un número váldo';
              return null;
            },
          ),
          CustomTextFormField(
            hint: 'Correo electrónico',
            icon: Icon(Icons.email_outlined),
            onChanged: (value){
              registerProvider.email = value;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Ingresar correo electrónico';
              if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Formato de correo electrónico no válido';
              return null;
            },
          ),
          CustomTextFormField(
            hint: 'Contraseña',
            icon: Icon(Icons.lock_outline),
            onChanged: (value){
              registerProvider.password = value;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Ingresar contraseña';
              if(value.length < 8) return 'Ingresa una contraseña de al menos 8 caracteres';
              if(!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) return 'Ingresa una contraseña con al menos una minúscula, una mayúscula y un número';
              return null;
            },

          ),
          CustomTextFormField(
            hint: 'Confirmar contraseña',
            icon: Icon(Icons.lock),
            onChanged: (value){
              registerProvider.confirmPassword = value;
            },
            validator: (value) {
              if(value == null || value.isEmpty)  return 'Confirmar contraseña';
              if(value != registerProvider.password) return 'Contraseñas no coinciden';
              return null;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final result = await showRadioOptionDialog(
                context: context,
                title: "Selecciona un rol",
                option1: "Comprador",
                option2: "Vendedor",
              );
              if (result != null) {
                registerProvider.setRole(result);
              }
            },
            child: const Text("Selecciona un rol"),
          ),
          if(registerProvider.roleError != null) ...[
            SizedBox(height: 5),
            Text(registerProvider.roleError!,
            style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
          SizedBox(height: 50),
          CustomElevatedButton(
            onPressed: (){
              if(registerProvider.validateUser()){
                registerProvider.saveUser();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cuenta creada: ${registerProvider.user?.name ?? ''}')),
                );
                context.goNamed('login');
              }
            },
            text: 'Crear',
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            onPressed: (){
              registerProvider.roleError = null;
              context.goNamed('login');
            },
            text: 'Regresar',
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ]
      )
    );
  }
}
