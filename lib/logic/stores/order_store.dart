// Create a class OrderStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_hackathon/logic/models/accessory_model.dart';
import 'package:here_hackathon/logic/models/delivery_man_model.dart';
import 'package:here_hackathon/logic/models/order_model.dart';
import 'package:here_hackathon/logic/models/shop_model.dart';

import '../../utils/const.dart';

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

    notifyListeners();
  }

  List<OrderModel> orders = [];

  Future<void> fetchOrderData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance.collection('orders').get().then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      OrderModel order = OrderModel.fromJson(data);
      order = order.copyWith(id: x.id);

      orders.add(order);
    }
    logger.d('orders: $orders');
  }

  List<ShopModel> shops = [];

  Future<void> fetchShopData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance.collection('shops').get().then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      ShopModel shop = ShopModel.fromJson(data);
      shop = shop.copyWith(id: x.id);

      shops.add(shop);
    }
    logger.d('shops: $shops');
  }

  List<RiderModel> riders = [];

  Future<void> fetchRiderData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance.collection('riders').get().then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      RiderModel rider = RiderModel.fromJson(data);
      rider = rider.copyWith(id: x.id);

      riders.add(rider);
    }
    logger.d('riders: $riders');
  }

  List<AccessoryModel> accessories = [];

  Future<void> fetchAccessoryData() async {
    // Get the specific document from the Firestore collection.
    List<DocumentSnapshot> docSnapshot = await FirebaseFirestore.instance.collection('accessories').get().then((value) => value.docs);

    // Check if the document exists and return its data.
    for (var x in docSnapshot) {
      // logger.d('Document data: ${x.data()}');

      final Map<String, dynamic> data = x.data() as Map<String, dynamic>;
      // logger.d('Document data: ${data['name']}');
      AccessoryModel accessory = AccessoryModel.fromJson(data);
      accessory = accessory.copyWith(id: x.id);

      accessories.add(accessory);
    }
    logger.d('accessories: $accessories');
  }
}
