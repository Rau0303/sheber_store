// lib/models/product.dart

class Product {
  final int id;
  final String barcode;
  final String name;
  final double sellingPrice;
  final String category;
  final String unit;
  final int quantity;
  final String? supplier;
  final String? description;
  final String? photo;

  Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.sellingPrice,
    required this.category,
    required this.unit,
    required this.quantity,
    this.supplier,
    this.description,
    this.photo,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      barcode: map['barcode'],
      name: map['name'],
      sellingPrice: map['selling_price'].toDouble(),
      category: map['category'],
      unit: map['unit'],
      quantity: map['quantity'],
      supplier: map['supplier'],
      description: map['description'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'barcode': barcode,
      'name': name,
      'selling_price': sellingPrice,
      'category': category,
      'unit': unit,
      'quantity': quantity,
      'supplier': supplier,
      'description': description,
      'photo': photo,
    };
  }
}
