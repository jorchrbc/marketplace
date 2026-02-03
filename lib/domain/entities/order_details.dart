class OrderDetails{
  final String address;
  final String status;
  final String payment_method;
  final double sub_total;
  final double tax;
  final double shipping;
  final double total;
  final List<Map<String, dynamic>> products;

  OrderDetails({
    required this.address,
    required this.status,
    required this.payment_method,
    required this.sub_total,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.products,
  });
}
