class CartItem {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String imageUrl; 
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get total => price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final product = json['product'];
    return CartItem(
      id: json['id'].toString(),
      productId: product['id'].toString(),
      name: product['name'],
      price: (product['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: '', // Mapear imagen si viene del backend
    );
  }
}
