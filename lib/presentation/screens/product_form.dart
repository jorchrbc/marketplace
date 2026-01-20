import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:marketplace/presentation/widgets/create_product/create_product_widgets.dart';
import 'package:marketplace/presentation/providers/create_product_provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});
 // final ImagePicker _picker = ImagePicker();
  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  //final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar producto"),
        leading: IconButton(
          icon: const Icon( Icons.arrow_back ),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home');
            }
          }
        ),
      ),
      body: const _ProductRegist()
    );
  }
}

class _ProductRegist extends StatelessWidget {
  const _ProductRegist();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const[
              _ProductForm(),

              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  const _ProductForm();

  @override
  State<_ProductForm> createState() => _ProductFormStateInternal();
}

class _ProductFormStateInternal extends State<_ProductForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createProductProvider = Provider.of<CreateProductProvider>(context);
    final size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        
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

          const SizedBox(height: 30),

          

          CustomTextfield(
            label: 'Nombre del producto',
            controller: _nameController,
            onChanged: (value) => createProductProvider.name = value,
          ),

          const SizedBox(height: 20),

          CustomTextfield(
            label: 'Precio',
            controller: _priceController,
            onChanged: (value) => createProductProvider.price = value,
            validator: (value) {
              if(value == null || value.trim().isEmpty) return 'Ingresar precio';
              final cleanedValue = value.trim();
              final regex = RegExp(r'^\d+(\.\d{1,2})?$');
              if(!regex.hasMatch(cleanedValue)) return 'Ingresa un precio váldo';
              return null;
            },
          ),
          SizedBox(height: 40),

             GestureDetector(
              onTap: () => createProductProvider.pickImage(),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: createProductProvider.image == null
                    ? const Center(child: Text('Seleccionar imagen'))
                    : Image.file(createProductProvider.image!, fit: BoxFit.cover),
              ),
            ),

          SizedBox(height: 20),
          /* ElevatedButton.icon(icon: const Icon(Icons.photo),
           label: const Text("Agregar imagenes"),
           onPressed: () async {
           //final imgs = await pickMul
           },
           ),
            */
          const SizedBox(height: 30),


          ElevatedButton(
          onPressed: () async {
            try{
             await createProductProvider.submitForm();
             // Limpiar campos form
             _nameController.clear();
             _priceController.clear();
             // Limpiar provider state
             createProductProvider.clearForm();

             if (mounted) {
               ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enviado correctamente'))
               );
             }
            }
            catch (e){
              if (mounted) {
                 ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text(e.toString()))
                 );
              }
            }
          } ,
           child: const Text("Guardar"),
          ),
          
        ],
      ),
    );
  }
}
