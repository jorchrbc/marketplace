class Details{
  final String name;
  final double price;
  final String? imagePath;
  final double stock;
  final String seller;

  Details({
    required this.name,
    required this.price,
    required this.stock,
    this.imagePath = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdpU431xPGZoWC2RW7DAlWe29mnpo2z5m13Q&s",
    required this.seller,
  });
}
