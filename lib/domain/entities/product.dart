import 'dart:io';

class Product{
  final String name;
  final double price;
  final File? imageFile;
  final int stock;
  final String dscrp;


  Product({
    required this.name,
    required this.price,
    this.imageFile,
    required this.stock,
    required this.dscrp,
  });
}
