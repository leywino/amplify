class Products {
  final String productName;
  final String brand;
  final String category;
  final int quantity;
  final int price;
  final int actualPrice;
  final String description;
  final String longDescription;
  final List? networkImageList;
  final String? id;

  Products(
      {required this.brand,
      required this.category,
      required this.quantity,
      required this.price,
      required this.actualPrice,
      required this.description,
      required this.longDescription,
      required this.productName,
      this.id,
      this.networkImageList});
}
