class Shoe {
  final int id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String color;
  dynamic quantity;

  Shoe(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.color,
      this.quantity = 0});

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        color: json['color'],
        quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'color': color,
      'quantity': quantity
    };
  }
}
