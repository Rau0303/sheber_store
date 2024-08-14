class Product {
  final int id;
  final String barcode;
  final String name;
  final double sellingPrice; // Изменено с int на double
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
      id: map['id'] != null ? (map['id'] is int ? map['id'] as int : int.tryParse(map['id'].toString()) ?? 0) : 0,
      barcode: map['barcode'] as String? ?? '',
      name: map['name'] as String? ?? '',
      sellingPrice: map['selling_price'] != null ? (map['selling_price'] is double ? map['selling_price'] as double : double.tryParse(map['selling_price'].toString()) ?? 0.0) : 0.0, // Изменено с int на double и добавлено преобразование
      category: map['category'] as String? ?? '',
      unit: map['unit'] as String? ?? '',
      quantity: map['quantity'] != null ? (map['quantity'] is int ? map['quantity'] as int : int.tryParse(map['quantity'].toString()) ?? 0) : 0,
      supplier: map['supplier'] as String?,
      description: map['description'] as String?,
      photo: map['photo'] as String?,
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

  @override
  String toString() {
    return 'Product{id: $id, barcode: $barcode, name: $name, sellingPrice: $sellingPrice, category: $category, unit: $unit, quantity: $quantity, supplier: $supplier, description: $description, photo: $photo}';
  }
}
