
import 'package:amplify/core/colors.dart';
import 'package:amplify/presentation/product_details/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ValueNotifier<bool> editNotifier = ValueNotifier(true);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();

  final _dummyProductDetails = [
    "HE400se",
    "HiFiMAN",
    "Headphones",
    "1",
    "9999",
    "Planar Magnetic Open Backs",
    "HiFiMAN, a leader in premium headphones founded by Dr Fang, has added the HE400se to their critically acclaimed Planar-Magnetic headphone series. Innovative technology reduces distortion, enhancing sound quality.",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: kMainBgColor,
          appBar: AppBar(
            backgroundColor: kMainBgColor,
            elevation: 0,
            // automaticallyImplyLeading: true,
            foregroundColor: Colors.black,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset("assets/back.svg")),
            title: const Text(
              "Product Details",
              style: TextStyle(
                color: kTextBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: editNotifier,
              builder: (context, editOrUpdate, child) => Column(
                children: [
                  Center(
                    child: SizedBox(
                        width: size.width * 0.7,
                        child: Image.network(
                            "https://cdn.shopify.com/s/files/1/0153/8863/products/Headphone-Zone-HiFiMAN-HE400se-1160-1160-7.jpg?v=1614245064&width=800")),
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Product Name",
                    textString: _dummyProductDetails[0],textController: nameController,
               
                    // enableTextField: false,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Brand",
                    enableTextField: !editOrUpdate,
                    textString: _dummyProductDetails[1],
                  textController: brandController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Category",
                    enableTextField: !editOrUpdate,
                    textString: _dummyProductDetails[2],
                    textController: categoryController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Quantity",
                    enableTextField: !editOrUpdate,
                    textString: _dummyProductDetails[3],
                   textController: quantityController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Price",
                    enableTextField: !editOrUpdate,
                    textString: _dummyProductDetails[4],
                    textController: priceController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Description",
                    enableTextField: !editOrUpdate,
                    textString: _dummyProductDetails[5],
                   textController: descriptionController,
                    height: 100,
                    maxLines: 2,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Long Description",
                    textString: _dummyProductDetails[6],
                    textController: longDescriptionController,
                    enableTextField: !editOrUpdate,
                    height: 130,
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: size.height * 0.1,
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                editNotifier.value = !editNotifier.value;
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(
                        horizontal: size.width * 0.32, vertical: 20)),
              ),
              child: ValueListenableBuilder(
                valueListenable: editNotifier,
                builder: (context, editOrUpdate, child) => Text(
                  editOrUpdate ? '   Edit   ' : 'Update',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
