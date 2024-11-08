import 'package:bun_app/controllers/order_controller.dart';
import 'package:bun_app/model/order_model.dart';
import 'package:bun_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F6F6),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: const Color(0xffF6F6F6),
      body: Consumer<AuthProvider>(builder: (context, value, child) {
        return FutureBuilder(
          future: value.fetchMyOrders(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            List<OrderModel> orders = value.myOrders;
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            0,
                            0.6,
                            0.9,
                          ],
                          colors: [
                            Color(0xff352A4C),
                            Color(0xff534966),
                            Color(0xff7B748A),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID - ${orders[index].orderID}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Text(
                            "Status - Paid",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                          Text(
                            "Total Amount - ${orders[index].totalAmount}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const Text(
                            "Items",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Divider(
                            color: Colors.grey.shade200,
                          ),
                          Column(
                            children: List.generate(
                                orders[index].items.length,
                                (i) => ListTile(
                                      leading: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    orders[index]
                                                        .items[i]
                                                        .model
                                                        .image),
                                                fit: BoxFit.cover)),
                                      ),
                                      title: Text(
                                        orders[index].items[i].model.title,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        "LKR ${orders[index].items[i].model.price}0",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    OrderController()
                                        .cancelOrder(orders[index].orderID);
                                    value.removeFromOrders(orders[index]);
                                  },
                                  child: const Text(
                                    "Cancel Order",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
