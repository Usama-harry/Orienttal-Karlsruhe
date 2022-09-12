class Item {
  final String id;
  final int position;
  final String name;
  final String description;
  final double price;

  Item({
    required this.id,
    required this.position,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
        id: data['id'],
        position: data['position'],
        name: data['name'],
        description: data['description'],
        price: double.parse(data['price'].toString()));
  }
}
