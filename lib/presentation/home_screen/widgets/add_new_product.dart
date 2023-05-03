import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:amplify/core/colors.dart';
import 'package:amplify/firebase/functions.dart';
import 'package:amplify/firebase/product_model.dart';
import 'package:amplify/presentation/product_details/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProductScreen extends StatelessWidget {
  AddNewProductScreen({super.key});

  final ValueNotifier<String> imagePathNotifer = ValueNotifier("");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController longDescriptionController =
      TextEditingController();

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
                        File file = File(pickedFile.path);
                        imagePathNotifer.value = await uploadImage(file);
                      }
                    },
                    child: SizedBox(
                      width: size.width * 0.7,
                      height: size.width * 0.7,
                      child: ValueListenableBuilder(
                        valueListenable: imagePathNotifer,
                        builder: (context, fileImageString, child) =>
                            fileImageString == ""
                                ? Container(
                                    height: size.height * 0.3,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Pick Image',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.network(
                                    fileImageString,
                                  ),
                      ),
                    ),
                  ),
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Product Name",
                  textController: nameController,
                  // textString: _dummyProductDetails[0],
                  // enableTextField: false,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Brand",
                  textController: brandController,
                  // enableTextField: !editOrUpdate,
                  // textString: _dummyProductDetails[1],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Category",
                  textController: categoryController,
                  // enableTextField: !editOrUpdate,
                  // textString: _dummyProductDetails[2],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Quantity",
                  textController: quantityController,
                  // enableTextField: !editOrUpdate,
                  // textString: _dummyProductDetails[3],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Price",
                  textController: priceController,
                  // enableTextField: !editOrUpdate,
                  // textString: _dummyProductDetails[4],
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Description",
                  textController: descriptionController,
                  // enableTextField: !editOrUpdate,
                  // textString: _dummyProductDetails[5],
                  height: 100,
                  maxLines: 2,
                ),
                DetailsTextFieldWidget(
                  size: size,
                  fieldName: "Long Description",
                  textController: longDescriptionController,
                  // textString: _dummyProductDetails[6],
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
              child: ValueListenableBuilder(
                valueListenable: imagePathNotifer,
                builder: (context, imagePath, child) {
                  return TextButton(
                    onPressed: () {
                      addProduct(
                          Products(
                              brand: brandController.text,
                              category: categoryController.text,
                              quantity: int.parse(quantityController.text),
                              price: int.parse(priceController.text),
                              description: descriptionController.text,
                              longDescription: longDescriptionController.text,
                              networkImageString: imagePath,
                              productName: nameController.text),
                          context);
                    },
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
                              horizontal: size.width * 0.32, vertical: 20)),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              )),
        ),
      ],
    );
  }
}

Future<String> uploadImage(File file) async {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  // Create a reference to the location where you want to upload the file
  firebase_storage.Reference ref =
      storage.ref().child('images/${DateTime.now().toString()}');

  // Upload the file to the specified path
  firebase_storage.UploadTask task = ref.putFile(file);

  // Listen for the upload progress
  task.snapshotEvents.listen((firebase_storage.TaskSnapshot snapshot) {
    print(
        'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
  });

  // Wait for the upload to complete
  await task;

  // Get the download URL
  String downloadURL = await ref.getDownloadURL();
  print('File uploaded successfully: $downloadURL');

  return downloadURL;
}
