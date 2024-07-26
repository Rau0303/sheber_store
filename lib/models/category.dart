// Модель категории
class Category {
  final int id;
  final String name;
  final String? photoUrl;

  Category({
    required this.id,
    required this.name,
    this.photoUrl,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      photoUrl: map['photo_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photo_url': photoUrl,
    };
  }
}