class Item {
  String title;
  String color;
  String size;
  double price;
  String imageUrl;
  int quantity;

  Item({
    required this.title,
    required this.color,
    required this.size,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}