class OrderModel {
  String? id;
  String name;
  String description;
  String imageUrl;
  String price;
  String quantity;
  String status;
  double sourceLatitude;
  double sourceLongitude;
  double destinationLatitude;
  double destinationLongitude;
  String sourceAddress;
  String destinationAddress;
  String sourceName;
  String destinationName;
  String sourcePhoneNumber;
  String destinationPhoneNumber;

  OrderModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.quantity,
    required this.status,
    required this.sourceLatitude,
    required this.sourceLongitude,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.sourceName,
    required this.destinationName,
    required this.sourcePhoneNumber,
    required this.destinationPhoneNumber,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      quantity: json['quantity'].toString(),
      status: json['status'],
      sourceLatitude: json['sourceLatitude'],
      sourceLongitude: json['sourceLongitude'],
      price: json['price'].toString(),
      destinationLatitude: json['destinationLatitude'],
      destinationLongitude: json['destinationLongitude'],
      sourceAddress: json['sourceAddress'],
      destinationAddress: json['destinationAddress'],
      sourceName: json['sourceName'],
      destinationName: json['destinationName'],
      sourcePhoneNumber: json['sourcePhoneNumber'].toString(),
      destinationPhoneNumber: json['destinationPhoneNumber'].toString(),
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
      'destinationLatitude': destinationLatitude,
      'destinationLongitude': destinationLongitude,
      'sourceAddress': sourceAddress,
      'destinationAddress': destinationAddress,
      'sourceName': sourceName,
      'destinationName': destinationName,
      'sourcePhoneNumber': sourcePhoneNumber,
      'destinationPhoneNumber': destinationPhoneNumber,
    };
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, price: $price, quantity: $quantity, status: $status, sourceLatitude: $sourceLatitude, sourceLongitude: $sourceLongitude, destinationLatitude: $destinationLatitude, destinationLongitude: $destinationLongitude, sourceAddress: $sourceAddress, destinationAddress: $destinationAddress, sourceName: $sourceName, destinationName: $destinationName, sourcePhoneNumber: $sourcePhoneNumber, destinationPhoneNumber: $destinationPhoneNumber)';
  }

  OrderModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? price,
    String? quantity,
    String? status,
    double? sourceLatitude,
    double? sourceLongitude,
    double? destinationLatitude,
    double? destinationLongitude,
    String? sourceAddress,
    String? destinationAddress,
    String? sourceName,
    String? destinationName,
    String? sourcePhoneNumber,
    String? destinationPhoneNumber,
  }) {
    return OrderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      sourceLatitude: sourceLatitude ?? this.sourceLatitude,
      sourceLongitude: sourceLongitude ?? this.sourceLongitude,
      destinationLatitude: destinationLatitude ?? this.destinationLatitude,
      destinationLongitude: destinationLongitude ?? this.destinationLongitude,
      sourceAddress: sourceAddress ?? this.sourceAddress,
      destinationAddress: destinationAddress ?? this.destinationAddress,
      sourceName: sourceName ?? this.sourceName,
      destinationName: destinationName ?? this.destinationName,
      sourcePhoneNumber: sourcePhoneNumber ?? this.sourcePhoneNumber,
      destinationPhoneNumber: destinationPhoneNumber ?? this.destinationPhoneNumber,
    );
  }

}
