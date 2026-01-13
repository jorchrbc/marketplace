class Product{
  final String name;
  final String price;
  final String? imagePath;


  Product({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "price": price,
      "image": imagePath,
    };
  }
}
