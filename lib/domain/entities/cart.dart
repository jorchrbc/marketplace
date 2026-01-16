import 'package:marketplace/domain/entities/cart_item.dart';

class Cart {
  final String id;
  final List<CartItem> items;
  final double subtotal;
  final double taxes;
  final double shipping;
  final double total;

  Cart({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.taxes,
    required this.shipping,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'].toString(), // Ensure String
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      subtotal: (json['subtotal'] as num).toDouble(),
      taxes: (json['taxes'] as num).toDouble(),
      shipping: (json['shipping'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
    );
  }
}
