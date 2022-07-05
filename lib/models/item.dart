class Item {
  final String id;
  final String name;
  final String description;
  final double price;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        price: double.parse(data['price'].toString()));
  }
}
