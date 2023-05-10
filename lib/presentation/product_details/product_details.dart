import 'dart:developer';
import 'dart:io';
import 'package:amplify/core/colors.dart';
import 'package:amplify/presentation/product_details/widgets/textfield_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../firebase/functions.dart';
import '../../firebase/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.data});

  final ValueNotifier<bool> editNotifier = ValueNotifier(true);
  final ValueNotifier<String> imagePathNotifier = ValueNotifier("");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
    final TextEditingController actualPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController longDescriptionController =
      TextEditingController();

  final Map<String, dynamic> data;

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
                    child: GestureDetector(
                      onTap: () {
                        editOrUpdate ? null : pickImage();
                      },
                      child: SizedBox(
                          width: size.width * 0.7,
                          child: Image.network(data["networkImageString"])),
                    ),
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Product Name",
                    textString: data["productName"],
                    textController: nameController,
                    enableTextField: !editOrUpdate,
                    // enableTextField: false,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Brand",
                    enableTextField: !editOrUpdate,
                    textString: data["brand"],
                    textController: brandController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Category",
                    enableTextField: !editOrUpdate,
                    textString: data["category"],
                    textController: categoryController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Quantity",
                    enableTextField: !editOrUpdate,
                    textString: data["quantity"].toString(),
                    textController: quantityController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Price",
                    enableTextField: !editOrUpdate,
                    textString: data["price"].toString(),
                    textController: priceController,
                  ),
                                 DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Actual Price",
                    enableTextField: !editOrUpdate,
                    textString: data["actualPrice"].toString(),
                    textController: actualPriceController,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Description",
                    enableTextField: !editOrUpdate,
                    textString: data["description"],
                    textController: descriptionController,
                    height: 100,
                    maxLines: 2,
                  ),
                  DetailsTextFieldWidget(
                    size: size,
                    fieldName: "Long Description",
                    textString: data["long description"],
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
            child: ValueListenableBuilder(
                valueListenable: editNotifier,
                builder: (context, editOrUpdate, child) =>
                    ValueListenableBuilder(
                      valueListenable: imagePathNotifier,
                      builder: (context, imagePath, child) => TextButton(
                        onPressed: () {
                          editNotifier.value = !editNotifier.value;
                          editOrUpdate
                              ? null
                              : updateProduct(
                                  Products(
                                      brand: brandController.text,
                                      category: categoryController.text,
                                      quantity:
                                          int.parse(quantityController.text),
                                      price: int.parse(priceController.text),
                                      actualPrice: int.parse(actualPriceController.text.trim()),
                                      description: descriptionController.text,
                                      longDescription:
                                          longDescriptionController.text,
                                      networkImageString: imagePath == ""
                                          ? data['networkImageString']
                                          : imagePath,
                                      productName: nameController.text),
                                  data['id'],
                                  context);
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        child: Text(
                          editOrUpdate ? '   Edit   ' : 'Update',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )),
          ),
        ),
      ],
    );
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      return;
    } else {
      File file = File(pickedFile.path);
      imagePathNotifier.value = await _uploadImage(file, data['productName']);
    }
  }
}

Future<String> _uploadImage(File file,String productName) async {
  final FirebaseStorage storage =
      FirebaseStorage.instance;

  Reference oldRef = storage.ref().child('images/$productName');
  await oldRef.delete();

  Reference ref =
      storage.ref().child('images/$productName');

  UploadTask task = ref.putFile(file);

  task.snapshotEvents.listen((TaskSnapshot snapshot) {
    log(
        'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
  });

  await task;

  String downloadURL = await ref.getDownloadURL();
  log('File uploaded successfully: $downloadURL');

  return downloadURL;
}
