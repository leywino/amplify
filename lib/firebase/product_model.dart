class Products {
  final String productName;
  final String brand;
  final String category;
  final int quantity;
  final int price;
  final String description;
  final String longDescription;
  final String imageString;
  final String? id;

  Products({
    required this.brand,
    required this.category,
    required this.quantity,
    required this.price,
    required this.description,
    required this.longDescription,
    required this.imageString,
    required this.productName,
    this.id,
  });
}