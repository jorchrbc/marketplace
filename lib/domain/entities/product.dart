import 'dart:io';

class Product{
  final String name;
  final double price;
  final File? imageFile;


  Product({
    required this.name,
    required this.price,
    this.imageFile,
  });
}
