import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3EC6BA),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(400, 150),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'MARKETPLACE',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Campo EMAIL o USUARIO
                    TextFormField(
                      //* Campo de validación para el email o usuario
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su correo o usuario';
                        }
                        
                        // Si contiene @ lo tratamos como email
                        if (value.contains('@')) {
                          if (value.contains(RegExp(r'[A-Z]'))) {
                            return 'El correo no debe contener mayúsculas';
                          }
                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );
                          if (!emailRegex.hasMatch(value)) {
                            return 'Ingrese un correo válido con el formato correcto';
                          }
                        } else {
                          // Validación para usuario (solo letras y números)
                          final userRegex = RegExp(r'^[a-zA-Z0-9]+$');
                          if (!userRegex.hasMatch(value)) {
                            return 'El usuario solo puede contener letras y números';
                          }
                        }
                        return null;  
                      },
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        hintText: 'EMAIL O USUARIO',
                        hintStyle: const TextStyle(fontSize: 12),
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo PASSWORD
                    TextFormField(
                      //* Campo de validación para la contraseña
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese su contraseña';
                        }
                        
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'PASSWORD ',
                        hintStyle: const TextStyle(fontSize: 12),
                        suffixIcon: const Icon(
                          Icons.lock_outline,
                          color: Colors.black87,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),

                    // Boton ENTRAR
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Datos válidos')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4DB6AC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'ENTRAR',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
