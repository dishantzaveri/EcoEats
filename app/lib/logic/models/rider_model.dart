class RiderModel {
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
  double rating;
  String imageUrl;
  String vehicleType;
  String vehicleNumber;
  double currentLatitude;
  double currentLongitude;

  RiderModel({
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
    required this.rating,
    required this.imageUrl,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.currentLatitude,
    required this.currentLongitude,
  });

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'].toString(),
      email: json['email'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'],
      addressLatitude: json['addressLatitude'],
      addressLongitude: json['addressLongitude'],
      status: json['status'],
      rating: json['rating'],
      imageUrl: json['imageUrl'],
      vehicleType: json['vehicleType'],
      vehicleNumber: json['vehicleNumber'],
      currentLatitude: json['currentLatitude'],
      currentLongitude: json['currentLongitude'],
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
      'rating': rating,
      'imageUrl': imageUrl,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'currentLatitude': currentLatitude,
      'currentLongitude': currentLongitude,
    };
  }

  @override
  String toString() {
    return 'DeliveryManModel(id: $id, name: $name, phone: $phone, email: $email, address: $address, city: $city, state: $state, country: $country, zipCode: $zipCode, addressLatitude: $addressLatitude, addressLongitude: $addressLongitude, status: $status, rating: $rating, imageUrl: $imageUrl, vehicleType: $vehicleType, vehicleNumber: $vehicleNumber, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude)';
  }

  RiderModel copyWith({
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
    double? rating,
    String? imageUrl,
    String? vehicleType,
    String? vehicleNumber,
    double? currentLatitude,
    double? currentLongitude,
  }) {
    return RiderModel(
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
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
    );
  }

}
