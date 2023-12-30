// Create a class OrderStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_hackathon/logic/models/accessory_model.dart';
import 'package:here_hackathon/logic/models/order_model.dart';
import 'package:here_hackathon/logic/models/rider_model.dart';
import 'package:here_hackathon/logic/models/shop_model.dart';

import '../../utils/const.dart';
import '../models/user_model.dart';

class OrderStore extends ChangeNotifier {
  OrderStore._();

  static final OrderStore _instance = OrderStore._();

  factory OrderStore() {
    return _instance;
  }

  void init() {
    fetchAllData();

    // run refresh connection every 30 seconds
    Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchAllData();
    });
  }

  void fetchAllData() {
    fetchOrderData();
    fetchShopData();
    fetchRiderData();
    fetchAccessoryData();
    fetchUserData();

    notifyListeners();
  }

  Map<String, OrderModel> orders = {};

  Future<void> fetchOrderData() async {
    orders.clear();
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      OrderModel order = OrderModel.fromJson(data);
      order = order.copyWith(id: x.id);

      orders.addEntries([MapEntry(x.id, order)]);
    }
    logger.d('orders: $orders');
  }

  Map<String, ShopModel> shops = {};

  Future<void> fetchShopData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance
        .collection('shops')
        .get()
        .then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      ShopModel shop = ShopModel.fromJson(data);
      shop = shop.copyWith(id: x.id);

      shops.addEntries([MapEntry(x.id, shop)]);
    }
    //logger.d('shops: $shops');
  }

  Map<String, RiderModel> riders = {};

  Future<void> fetchRiderData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance
        .collection('riders')
        .get()
        .then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      RiderModel rider = RiderModel.fromJson(data);
      rider = rider.copyWith(id: x.id);

      riders.addEntries([MapEntry(x.id, rider)]);
    }
    //logger.d('riders: $riders');
  }

  Map<String, AccessoryModel> accessories = {};

  Future<void> fetchAccessoryData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance
        .collection('accessory')
        .get()
        .then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      AccessoryModel accessory = AccessoryModel.fromJson(data);
      accessory = accessory.copyWith(id: x.id);

      accessories.addEntries([MapEntry(x.id, accessory)]);
    }
    // logger.d('accessories: $accessories');
  }

  Map<String, UserModel> users = {};

  Future<void> fetchUserData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      UserModel user = UserModel.fromJson(data);
      user = user.copyWith(id: x.id);

      users.addEntries([MapEntry(x.id, user)]);
    }
    // logger.d('users: $users');
  }
}
