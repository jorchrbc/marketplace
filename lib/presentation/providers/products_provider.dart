import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FormProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  File? get image => _image;

  String name = '';
  String price = '';

 
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
   
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }

 
  Future<void> submitForm() async {
    if (_image == null) {
      throw Exception('No se ha seleccionado imagen');
    }

    final uri = Uri.parse('https://tu-api.com/products');

    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['price'] = price;

    request.files.add(
      await http.MultipartFile.fromPath(
        'image', // nombre del campo esperado por la API
        _image!.path,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Error al enviar formulario');
    }
  }
}
