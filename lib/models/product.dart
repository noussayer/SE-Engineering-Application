import 'dart:convert';
class Product {
  final String name;
  final String description;
  final DateTime date;
  final List<String> images;
  final String category;
  final String customer;
  final String? id;
  Product({
    required this.name,
    required this.description,
    required this.date,
    required this.images,
    required this.category,
    required this.customer,
    this.id,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'date': date.toIso8601String(),
      'images': images,
      'category': category,
      'customer': customer,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()), 
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      customer: map['customer'] ?? '',
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));
}
