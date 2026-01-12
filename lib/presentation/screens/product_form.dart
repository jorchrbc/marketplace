import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/providers/product_provider.dart';
import 'dart:io';
import 'package:marketplace/presentation/widgets/widgets.dart';

class ProductRegist extends StatelessWidget {
  const ProductRegist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _ProductView()
      ),
    );
  }
}

class _ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Column(
        children: [
          Text(
            'Crear producto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40
            )
          ),
          SizedBox(height: 20),
          _ProductForm()
        ]
      )
    );
  }
}


class _ProductForm extends StatefulWidget{
  const _ProductForm();

  @override
  State<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<_ProductForm> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final size = MediaQuery.of(context).size;
    File? selectedImage;
    return Form(
      key: productProvider.formKey,
      child: Column(
        
        children: [
          Stack(
              children: [
                Container(
                  height: size.height * 0.15,
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
                          'Registrar producto',
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

          

          CustomTextfield(
            label: 'Nombre del producto',
            onChanged: (value) {productProvider.name = value;},
            validator:(value){
              if(value == null || value.isEmpty) return 'Ingresar nombre';
              if(!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) return 'Solo se permiten letras';
              return null;
            }
          ),

          const SizedBox(height: 20),

          CustomTextfield(
            label: 'Precio',
            onChanged: (value) { productProvider.price = value;},
            validator: (value) {
              if(value == null || value.trim().isEmpty) return 'Ingresar precio';
              final cleanedValue = value.trim();
              final regex = RegExp(r'^\d+(\.\d{1,2})?$');
              if(!regex.hasMatch(cleanedValue)) return 'Ingresa un precio válido';
              return null;
            },
          ),
          SizedBox(height: 40),

          ImagePickerWidget(onImageSelected: (image){
            selectedImage = image;
          }
          ),

          const SizedBox(height: 60),

          ElevatedButton(onPressed: (){
            if (selectedImage != null){
              print(selectedImage!.path);
            }
          }, child: const Text('Guardar')),
          
          SizedBox(height: 50),
          CustomElevatedButton(
            onPressed: () async {
              if(productProvider.validateProduct()){
                productProvider.saveProduct();
                try{
                  await productProvider.register(productProvider.product!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Producto creado: ${productProvider.product?.name ?? ''}')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al crear producto: $e')),
                  );
                }
              }
            },
            text: 'Crear',
          ),
        ],
      ),
    );
  }


  }
