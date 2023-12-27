import 'package:flutter/foundation.dart';

class ShopModel {
  String id;
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
  double rating;

  ShopModel({
    required this.id,
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
      accessories: json['accessories'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      zipCode: json['zipCode'],
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ShopModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        listEquals(other.accessories, accessories) &&
        other.address == address &&
        other.city == city &&
        other.state == state &&
        other.country == country &&
        other.zipCode == zipCode &&
        other.addressLatitude == addressLatitude &&
        other.addressLongitude == addressLongitude &&
        other.status == status &&
        other.rating == rating;
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
    double? rating,
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
