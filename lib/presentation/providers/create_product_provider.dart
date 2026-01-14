import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import 'package:marketplace/domain/repositories/products_repository.dart';
import 'package:marketplace/domain/entities/product.dart';

class CreateProductProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? get image => _image;
  
  final ProductsRepository productsRepository;

  CreateProductProvider({required this.productsRepository});

  String name = '';
  String price = '';

 
  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
   
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      notifyListeners();
    }
  }
  
  Future<void> submitForm() async{
    if (name.isEmpty || price.isEmpty){
      throw Exception('El nombre o precio está vacío');
    }
    final product = Product(
      name: name,
      price: double.parse(price),
      imageFile:_image
    );
    
    await productsRepository.createProduct(product);
  }
}
