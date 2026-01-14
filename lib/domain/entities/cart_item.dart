class CartItem {
  final String id;
  final String name;
  final double price;
  final String imageUrl; // Using String for URL or asset path
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });

  double get total => price * quantity;
}
