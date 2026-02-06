class Details{
  final String name;
  final int stock;
  final String price;
  final String description;
  final String imagePath;
  final String seller;
  final String? id;

  Details({
    required this.name,
    required this.price,
    required this.stock,
    this.description = '',
    this.imagePath = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdpU431xPGZoWC2RW7DAlWe29mnpo2z5m13Q&s",
    required this.seller,
    this.id,
  });
}
