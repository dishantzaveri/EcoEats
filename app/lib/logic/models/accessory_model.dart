class AccessoryModel {
  String? id;
  String name;
  String description;
  String imageUrl;
  String price;
  String quantity;
  String status;
  double sourceLatitude;
  double sourceLongitude;

  AccessoryModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.status,
    required this.sourceLatitude,
    required this.sourceLongitude,
  });

  factory AccessoryModel.fromJson(Map<String, dynamic> json) {
    return AccessoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: json['price'],
      quantity: json['quantity'],
      status: json['status'],
      sourceLatitude: json['sourceLatitude'],
      sourceLongitude: json['sourceLongitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
      'status': status,
      'sourceLatitude': sourceLatitude,
      'sourceLongitude': sourceLongitude,
    };
  }

  @override
  String toString() {
    return 'AccessoryModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, quantity: $quantity, status: $status, sourceLatitude: $sourceLatitude, sourceLongitude: $sourceLongitude)';
  }


  AccessoryModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? price,
    String? quantity,
    String? status,
    double? sourceLatitude,
    double? sourceLongitude,
  }) {
    return AccessoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      sourceLatitude: sourceLatitude ?? this.sourceLatitude,
      sourceLongitude: sourceLongitude ?? this.sourceLongitude,
    );
  }
}
