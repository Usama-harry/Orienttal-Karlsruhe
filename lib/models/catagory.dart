import '../models/item.dart';

class Catagory {
  final String id;
  final String name;
  final String imageUrl;
  List<Item> items;

  Catagory({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  factory Catagory.fromMap(Map<String, dynamic> data) {
    return Catagory(
      id: data['id'],
      name: data['name'],
      imageUrl: data['imageUrl'],
      items: (data['items'] as List<dynamic>)
          .map((item) => Item.fromMap(item))
          .toList(),
    );
  }
}
