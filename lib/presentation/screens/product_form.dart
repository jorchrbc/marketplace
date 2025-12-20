import 'package:flutter/material.dart';
import 'package:marketplace/presentation/widgets/product/custom_textfield.dart';
import 'package:marketplace/config/provider/ProductForm_Provider.dart';



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

class _ProductForm extends StatelessWidget {
  const _ProductForm();

  @override
  Widget build(BuildContext context) {
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
            onChanged: (value) => FormProvider().name = value,
          ),

          const SizedBox(height: 20),

          CustomTextfield(
            label: 'Precio',
            onChanged: (value) => FormProvider().price = value,
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
              onTap: () => FormProvider().pickImage(),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: FormProvider().image == null
                    ? const Center(child: Text('Seleccionar imagen'))
                    : Image.file(FormProvider().image!, fit: BoxFit.cover),
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
             await FormProvider().submitForm();
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Enviado correctamente'))
             );  
            }
            catch (e){
               ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(e.toString()))
               );
            }
          } ,
           child: const Text("Guardar"),
          ),
          
        ],
      ),
    );
  }


  }
