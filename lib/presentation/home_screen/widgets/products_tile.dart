import 'package:flutter/material.dart';

import '../../product_details/product_details.dart';

class ProductsTiles extends StatelessWidget {
  ProductsTiles({
    super.key,
  });

  final _dummyProductImages = [
    "https://cdn.shopify.com/s/files/1/0153/8863/products/Headphone-Zone-HiFiMAN-HE400se-1160-1160-7.jpg?v=1614245064&width=800",
    "https://cdn.shopify.com/s/files/1/0153/8863/products/KZ-ZSN-Pro-X-Black-01_960774c7-2c57-4f9c-ab41-12cff3d684de.jpg?v=1650864564&width=800",
    "https://cdn.shopify.com/s/files/1/0153/8863/products/Headphone-Zone-Sony-WF-1000XM4-Black-07.jpg?v=1642060231&width=800",
    "https://cdn.shopify.com/s/files/1/0153/8863/products/astell-kern-ak-xb10-headphone-zone-13983714246719.jpg?v=1589284696&width=800",
    "https://cdn.shopify.com/s/files/1/0153/8863/products/Headphone-Zone-Sony-NW-ZX707-012.jpg?v=1674635770&width=800",
  ];

  final _dummyProductTitles = [
    "Hi-Fi Man - Headphones",
    "KG3 - Pro",
    "SONY TWS",
    "KSA DAC Wireless",
    "SONY WF-068",
  ];

  final _dummyProductQuantity = [
    "3",
    "15",
    "11",
    "5",
    "1",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
      5,
      (index) => GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(),
            )),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(_dummyProductImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  _dummyProductTitles[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Text(
                _dummyProductQuantity[index],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
