// Create a class OrderStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:here_hackathon/logic/models/order_model.dart';

import '../../utils/const.dart';

class OrderStore extends ChangeNotifier {
  OrderStore._();

  static final OrderStore _instance = OrderStore._();

  factory OrderStore() {
    return _instance;
  }

  List<OrderModel> orders = [];

  Future<void> fetchOrderData(String documentId) async {
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
}
