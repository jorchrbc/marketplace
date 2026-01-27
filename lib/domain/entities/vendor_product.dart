class VendorProduct {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String? image;

  VendorProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    this.image,
  });

  factory VendorProduct.fromJson(Map<String, dynamic> json) {
    return VendorProduct(
      id: json['id'].toString(),
      name: json['name'],
      // Handle price as int or double safely
      price: (json['price'] is int) 
          ? (json['price'] as int).toDouble() 
          : (json['price'] as double? ?? 0.0),
      stock: int.tryParse(json['stock'].toString()) ?? 0,
      image: json['image'],
    );
  }
}
