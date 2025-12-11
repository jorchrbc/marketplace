import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/register/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _RegisterView()
    );
  }
}

class _RegisterView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Create account',
                style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 27
                )
              ),
              SizedBox(height: 30),
              _RegisterForm(),
              SizedBox(height: 100),
              ElevatedButton(
                onPressed: (){},
                child: Text('Register')
              )
            ]
          )
        )
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
    return Form(
      child: Column(
        children: [
          CustomTextFormField(
            hint: 'Name',
            icon: Icon(Icons.person)
          ),
          SizedBox(height: 15),
          CustomTextFormField(
            hint: 'Phone',
            icon: Icon(Icons.phone)
          ),
          SizedBox(height: 15),
          CustomTextFormField(
            hint: 'Email',
            icon: Icon(Icons.email)
          ),
          SizedBox(height: 15),
          CustomTextFormField(
            hint: 'Password',
            icon: Icon(Icons.password)
          ),
          SizedBox(height: 15),
          CustomTextFormField(
            hint: 'Confirm password',
            icon: Icon(Icons.remove_red_eye)
          )
        ]
      )
    );
  }
}