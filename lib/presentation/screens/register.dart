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
      child: Column(
        children: [
          CustomTextFormField(
            hint: 'Nombre',
            errorText: registerProvider.nameError,
            icon: Icon(Icons.person_outlined),
            onChanged: (value){
              registerProvider.name = value;
              registerProvider.validateName();
            },
          ),
          CustomTextFormField(
            hint: 'Apellidos',
            errorText: registerProvider.lastNameError,
            icon: Icon(Icons.person),
            onChanged: (value){
              registerProvider.lastName = value;
              registerProvider.validateLastName();
            },
          ),
          CustomTextFormField(
            hint: 'Teléfono',
            errorText: registerProvider.phoneError,
            icon: Icon(Icons.phone_outlined),
            onChanged: (value){
              registerProvider.phone = value;
              registerProvider.phoneErrorApi = null;
              registerProvider.validatePhone();
            },
          ),
          CustomTextFormField(
            hint: 'Correo electrónico',
            errorText: registerProvider.emailError,
            icon: Icon(Icons.email_outlined),
            onChanged: (value){
              registerProvider.email = value;
              registerProvider.emailErrorApi = null;
              registerProvider.validateEmail();
            },
          ),
          CustomTextFormField(
            hint: 'Contraseña',
            errorText: registerProvider.passwordError,
            icon: Icon(Icons.lock_outline),
            onChanged: (value){
              registerProvider.password = value;
              registerProvider.passwordErrorApi = null;
              registerProvider.validatePassword();
            },

          ),
          CustomTextFormField(
            hint: 'Confirmar contraseña',
            errorText: registerProvider.confirmPasswordError,
            icon: Icon(Icons.lock),
            onChanged: (value){
              registerProvider.confirmPassword = value;
              registerProvider.validateConfirmPassword();
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
                registerProvider.role = result;
                registerProvider.validateRole();
              } else {
                registerProvider.validateRole();
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
            onPressed: () async {
              bool validated = true;
              if(!registerProvider.validateAllFields()){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error en los datos')),
                );
              } else{
                try{
                  validated = await registerProvider.validateUser();
                  if(validated){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cuenta creada: ${registerProvider.user?.name ?? ''}')),
                    );
                    registerProvider.cleanAll;
                    context.goNamed('login');
                  } else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error en los datos')),
                    );
                  }
                } catch (e) {
                  print("error capturado: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al crear cuenta: $e')),
                  );
                }
              }
            },
            text: 'Crear',
          ),
          SizedBox(height: 15),
          CustomElevatedButton(
            onPressed: (){
              registerProvider.cleanAll();
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
