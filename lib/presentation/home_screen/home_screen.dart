import 'package:amplify/presentation/home_screen/widgets/add_new_product.dart';
import 'package:amplify/presentation/home_screen/widgets/orders_tile.dart';
import 'package:amplify/presentation/home_screen/widgets/products_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/colors.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: kMainBgColor,
              elevation: 0,
              automaticallyImplyLeading: false,
              foregroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey,
                    child: SvgPicture.asset(
                      "assets/person.svg",
                      height: 20,
                    ),
                  ),
                ),
              ],
              title: const Text(
                "Amplifier",
                style: TextStyle(
                  color: kTextBlackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      'Products',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: kTextBlackColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        // color: kTextBlackColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
                unselectedLabelColor: Colors.grey,
                labelColor: kTextBlackColor,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: ProductsTiles(),
                ),
                SingleChildScrollView(
                  child: OrdersTiles(),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNewProductScreen(),
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.black),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(
                          horizontal: size.width * 0.28, vertical: 20)),
                ),
                child: const Text(
                  'Add Product',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
