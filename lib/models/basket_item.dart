class BasketItem {
  final String title;
  final double price;
  final int quantity;
  final List<String> photoURLs;

  BasketItem({
    required this.title,
    required this.price,
    required this.quantity,
    required this.photoURLs,
  });
}
