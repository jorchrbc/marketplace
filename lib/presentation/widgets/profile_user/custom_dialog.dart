import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/presentation/widgets/create_product/custom_textfield.dart';

class CustomDialog extends StatelessWidget {
  final String names;
  final String phone;
  const CustomDialog(this.phone, this.names, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextfield(label: 'Nombre',hint: names),
          SizedBox(height: 5),
          CustomTextfield(label: 'Cel',hint: phone),
          SizedBox(height: 5),
          Row(
            children: [
              TextButton(onPressed: (){
                Navigator.of(context).pop;
              },
               child: Text('Cancelar')),

              TextButton(onPressed: ()
              {
                /*
                TODO Actualizar info
                */

                context.goNamed('user-profile');
              }, child: Text('Guardar'))
            ],
          )
        ],
      ),
    );
  }
}