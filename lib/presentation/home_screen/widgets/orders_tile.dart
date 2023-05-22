import 'package:amplify/presentation/order_details/order_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersTiles extends StatelessWidget {
  OrdersTiles({
    super.key,
  });

  // final _dummyOrdersTitles = [
  //   "Order 1581581",
  //   "Order 7845123",
  //   "Order 2468024",
  //   "Order 3334445",
  //   "Order 7779990",
  // ];

  final List<String> _list = <String>[
    'Pending',
    'Shipped',
    'Out for Delivery',
    'Delivered',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error occured"),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("There are no orders"),
              );
            }
            final orderList = snapshot.data!.docs.toList();
            return Column(
              children: List.generate(orderList.length, (index) {
                DateTime dateTime =
                    DateTime.parse('2023-05-22 11:13:55.624191');
                DateFormat formatter = DateFormat.yMMMMd().add_Hm();

                String formattedDateTime = formatter.format(dateTime);

                return GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderDetails(orderList: orderList[index]),
                      )),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orderList[index]['email'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  formattedDateTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 80,
                            child: Text(
                              _list[orderList[index]['orderStatusIndex']],
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        )
      ],
    );
  }
}
