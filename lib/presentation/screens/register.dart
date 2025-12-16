import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/register/custom_text_form_field.dart';

class RegisterScreen extends StatelessWidget{
  const RegisterScreen({super.key});
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Marketplace'),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
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
                'Register',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                )
              ),
              SizedBox(height: 30),
              _RegisterForm(),
              SizedBox(height: 100),
              
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
  final name_controller = TextEditingController();
  final phone_controller = TextEditingController();
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  final confirm_password_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    name_controller.dispose();
    phone_controller.dispose();
    email_controller.dispose();
    password_controller.dispose();
    confirm_password_controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            CustomTextFormField(
              hint: 'Name',
              icon: Icon(Icons.person),
              controller: name_controller,
              validator: (value) {
                if(value == null || value.isEmpty) return 'Name is required';
                if(!RegExp(r'^[A-Za-z]+$').hasMatch(value)) return 'Only letters are allowed';
                return null;
              }
            ),
            SizedBox(height: 25),
            CustomTextFormField(
              hint: 'Phone',
              icon: Icon(Icons.phone),
              controller: phone_controller,
              validator: (value) {
                if(value == null || value.trim().isEmpty) return 'Phone is required';
                final cleaned_value = value.replaceAll(RegExp(r'[\s-]'), '');
                if(!RegExp(r'^(\+52|52|0)?(1)?[1-9][0-9]{9}$').hasMatch(cleaned_value)) return 'Enter a valid phone';
                return null;
              }
            ),
            SizedBox(height: 25),
            CustomTextFormField(
              hint: 'Email',
              icon: Icon(Icons.email),
              controller: email_controller,
              validator: (value) {
                if(value == null || value.isEmpty) return 'Please enter some text';
                if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Not email form allowed';
                return null;
              }
            ),
            SizedBox(height: 25),
            CustomTextFormField(
              hint: 'Password',
              icon: Icon(Icons.password),
              controller: password_controller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'Please enter some text';
                }
                if(value.length < 8) return 'Please enter a password of at least 8 characters';
                if(!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).+$').hasMatch(value)) return 'Please enter a password using lower and uppercase, at least a number and a special character';
                return null;
              }
            ),
            SizedBox(height: 25),
            CustomTextFormField(
              hint: 'Confirm password',
              icon: Icon(Icons.remove_red_eye),
              controller: confirm_password_controller,
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'Please enter some text';
                }
                if(value != password_controller.text) return 'Passwords do not match';
                return null;
              }
            ),
            SizedBox(height: 100),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: (){
                    // print('name_controller: ${name_controller.text}');
                    // print('phone_controller: ${phone_controller.text}');
                    // print('email_controller: ${email_controller.text}');
                    // print('password_controller: ${password_controller.text}');
                    // print('confirm_passowrd_controller: ${confirm_password_controller.text}');
                    if(_formKey.currentState!.validate()){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
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
        ),
      )
    );
  }
}
