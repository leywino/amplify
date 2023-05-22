import 'package:amplify/firebase/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderStatusWidget extends StatelessWidget {
  OrderStatusWidget({
    super.key,
    required this.id,
    required this.orderStatusIndex,
  });

  final String id;
  final int orderStatusIndex;
  final ValueNotifier<String> orderStatusStringNotifier = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    orderStatusStringNotifier.value = _list[orderStatusIndex];
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     color: Colors.grey,
      //     width: 1.0,
      //   ),
      //   borderRadius: BorderRadius.circular(20.0),
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ValueListenableBuilder(
            valueListenable: orderStatusStringNotifier,
            builder: (context, dropdownValue, child) => DropdownButton<String>(
              value: dropdownValue,
              icon: SvgPicture.asset(
                "assets/dropdown.svg",
              ),
              iconSize: 24,
              elevation: 0,
              borderRadius: BorderRadius.zero,
              style: const TextStyle(color: Colors.black, fontSize: 16),
              underline: Container(),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                orderStatusStringNotifier.value = value!;
                int orderStatusIndex =
                    _list.indexWhere((element) => element == value);
                updateOrderStatus(id, context, orderStatusIndex);
              },
              items: _list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

const List<String> _list = <String>[
  'Pending',
  'Shipped',
  'Out for Delivery',
  'Delivered',
  'Cancelled'
];
