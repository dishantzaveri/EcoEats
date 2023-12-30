class ShopModel {
  String? id;
  String name;
  String description;
  String imageUrl;
  List<String>? accessories;
  String address;
  String city;
  String state;
  String country;
  String zipCode;
  double addressLatitude;
  double addressLongitude;
  String status;
  String rating;

  ShopModel({
    this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    this.accessories,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.status,
    required this.rating,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      // Iterate over the list of accessories and convert each item to a String.
      accessories: List<String>.from(json['accessories']),
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'].toString(),
      addressLatitude: json['addressLatitude'],
      addressLongitude: json['addressLongitude'],
      status: json['status'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'accessories': accessories,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'addressLatitude': addressLatitude,
      'addressLongitude': addressLongitude,
      'status': status,
      'rating': rating,
    };
  }

  @override
  String toString() {
    return 'ShopModel(id: $id, name: $name, description: $description, imageUrl: $imageUrl, accessories: $accessories, address: $address, city: $city, state: $state, country: $country, zipCode: $zipCode, addressLatitude: $addressLatitude, addressLongitude: $addressLongitude, status: $status, rating: $rating)';
  }

  ShopModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    List<String>? accessories,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    double? addressLatitude,
    double? addressLongitude,
    String? status,
    String? rating,
  }) {
    return ShopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      accessories: accessories ?? this.accessories,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      addressLatitude: addressLatitude ?? this.addressLatitude,
      addressLongitude: addressLongitude ?? this.addressLongitude,
      status: status ?? this.status,
      rating: rating ?? this.rating,
    );
  }
}
