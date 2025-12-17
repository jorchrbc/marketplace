import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:marketplace/presentation/providers/register_provider.dart';
import 'package:marketplace/presentation/widgets/register/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _RegisterView()
    );
  }
}

class _RegisterView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
      child: Column(
        children: [
          Text(
            'Register',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: 40
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.08),
          _RegisterForm(),
          
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
            hint: 'Name',
            icon: Icon(Icons.person_outlined),
            onChanged: (value){
              registerProvider.name = value!;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Name is required';
              if(!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) return 'Only letters are allowed';
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextFormField(
            hint: 'Last name',
            icon: Icon(Icons.person),
            onChanged: (value){
              registerProvider.lastName = value!;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Last name is required';
              if(!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) return 'Only letters are allowed';
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextFormField(
            hint: 'Phone',
            icon: Icon(Icons.phone),
            onChanged: (value){
              registerProvider.phone = value!;
            },
            validator: (value) {
              if(value == null || value.trim().isEmpty) return 'Phone is required';
              final cleanedValue = value.replaceAll(RegExp(r'[\s-]'), '');
              if(!RegExp(r'^(\+52|52|0)?(1)?[1-9][0-9]{9}$').hasMatch(cleanedValue)) return 'Enter a valid phone';
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextFormField(
            hint: 'Email',
            icon: Icon(Icons.email),
            onChanged: (value){
              registerProvider.email = value!;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Email is required';
              if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Not email form allowed';
              return null;
            },
          ),
          SizedBox(height: 25),
          CustomTextFormField(
            hint: 'Password',
            icon: Icon(Icons.lock_outline),
            onChanged: (value){
              registerProvider.password = value!;
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Password is required';
              if(value.length < 8) return 'Please enter a password of at least 8 characters';
              if(!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).+$').hasMatch(value)) return 'Please enter a password using lower and uppercase, at least a number and a special character';
              return null;
            },

          ),
          SizedBox(height: 25),
          CustomTextFormField(
            hint: 'Confirm password',
            icon: Icon(Icons.lock),
            onChanged: (value){
              registerProvider.confirmPassword = value!;
            },
            validator: (value) {
              if(value == null || value.isEmpty)  return 'Confirm password is required';
              if(value != registerProvider.password) return 'Passwords do not match';
              return null;
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.1),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  if(registerProvider.validateUser()){
                    registerProvider.saveUser();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User saved: ${registerProvider.user?.name ?? ''}')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                )
              ),
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                )
              )
            ),
          )
        ]
      )
    );
  }
}
