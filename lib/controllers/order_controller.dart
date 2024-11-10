import 'package:bun_app/model/order_model.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

// Controller for managing orders in the Firestore database.
class OrderController {
  // Reference to the 'Orders' collection in Firestore.
  CollectionReference orders = FirebaseFirestore.instance.collection("Orders");

  // Saves the details of a new order to Firestore.
  // This method generates a unique order ID, assigns it to the order model
  Future<void> saveOrderDetails(OrderModel model) async {
    try {
      String orderID = orders.doc().id;
      model.orderID = orderID;
      Map<String, dynamic> orderData = model.toJson();
      await orders.doc(orderID).set(orderData).then((value) {
        Logger().f("Order Saved");
      });
    } catch (e) {
      Logger().e(e);
    }
  }

  // Fetches the list of orders for the current user.
  Future<List<OrderModel>> fetchMyOrders(BuildContext context) async {
    // Get the current user's UID from the AuthProvider.
    String uid = Provider.of<AuthProvider>(context, listen: false).user!.uid;
    List<OrderModel> orderList = [];
    QuerySnapshot snapshot =
        await orders.where("user.uid", isEqualTo: uid).get();

    for (var order in snapshot.docs) {
      OrderModel myOrder =
          OrderModel.fromJson(order.data() as Map<String, dynamic>);
      orderList.add(myOrder);
    }
    return orderList;
  }

  // Cancels an order by removing it from Firestore.
  // Deletes the order document with the given order ID.
  Future<void> cancelOrder(String id) async {
    await orders.doc(id).delete().then((value) {
      Logger().f("Order Cancelled - $id");
    });
  }
}
