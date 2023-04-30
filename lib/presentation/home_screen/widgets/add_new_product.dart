import 'dart:io';

import 'package:amplify/core/colors.dart';
import 'package:amplify/presentation/product_details/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductScreen extends StatelessWidget {
  AddNewProductScreen({super.key});

  final ValueNotifier<String> imagePathNotifer = ValueNotifier("");

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
            title: Text(
              "Product Details",
              style: const TextStyle(
                color: kTextBlackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (pickedFile == null) {
                        return;
                      } else {
                        imagePathNotifer.value = pickedFile.path;
                      }
                    },
                    child: SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      child: ValueListenableBuilder(
                        valueListenable: imagePathNotifer,
                        builder: (context, imageString, child) =>
                            imageString == ""
                                ? Container(
                                    height: size.height * 0.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    File(imageString),
                                  ),
                      ),
                    ),
                  ),
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Product Name",
                  // controllerText: _dummyProductDetails[0],
                  // enableTextField: false,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Brand",
                  // enableTextField: !editOrUpdate,
                  // controllerText: _dummyProductDetails[1],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Category",
                  // enableTextField: !editOrUpdate,
                  // controllerText: _dummyProductDetails[2],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Quantity",
                  // enableTextField: !editOrUpdate,
                  // controllerText: _dummyProductDetails[3],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Price",
                  // enableTextField: !editOrUpdate,
                  // controllerText: _dummyProductDetails[4],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Description",
                  // enableTextField: !editOrUpdate,
                  // controllerText: _dummyProductDetails[5],
                  height: 100,
                  maxLines: 2,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Long Description",
                  // controllerText: _dummyProductDetails[6],
                  // enableTextField: !editOrUpdate,
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
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {},
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
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
