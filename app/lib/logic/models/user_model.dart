class UserModel {
  String? id;
  String name;
  String phone;
  String email;
  String address;
  String city;
  String state;
  String country;
  String zipCode;
  double addressLatitude;
  double addressLongitude;
  String status;
  String imageUrl;
  List<String>? orders;

  UserModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.addressLatitude,
    required this.addressLongitude,
    required this.status,
    required this.imageUrl,
    this.orders,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'].toString(),
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'].toString(),
      addressLatitude: json['addressLatitude'],
      addressLongitude: json['addressLongitude'],
      imageUrl: json['imageUrl'],
      orders: List<String>.from(json['orders']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipCode': zipCode,
      'addressLatitude': addressLatitude,
      'addressLongitude': addressLongitude,
      'status': status,
      'imageUrl': imageUrl,
      'orders': orders,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, phone: $phone, email: $email, address: $address, city: $city, state: $state, country: $country, zipCode: $zipCode, addressLatitude: $addressLatitude, addressLongitude: $addressLongitude, status: $status, imageUrl: $imageUrl, orders: $orders)';
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? state,
    String? country,
    String? zipCode,
    double? addressLatitude,
    double? addressLongitude,
    String? status,
    String? imageUrl,
    List<String>? orders,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      addressLatitude: addressLatitude ?? this.addressLatitude,
      addressLongitude: addressLongitude ?? this.addressLongitude,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      orders: orders ?? this.orders,
    );
  }
}
