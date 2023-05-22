import 'dart:developer';
import 'package:amplify/presentation/widgets/text_field_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/colors.dart';

class EditImageScreen extends StatefulWidget {
  EditImageScreen(
      {super.key,
      required this.imageList,
      required this.id,
      required this.productName});

  final List imageList;
  final List colorStringList = [];
  final String id;
  final String productName;
  final List<TextEditingController> controllers = [];

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  @override
  void dispose() {
    widget.controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < widget.imageList.length; i++) {
      widget.controllers.add(TextEditingController());
    }
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kMainBgColor,
          elevation: 0,
          // automaticallyImplyLeading: true,
          foregroundColor: Colors.black,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset("assets/back.svg")),
          title: const Text(
            "Edit Images",
            style: TextStyle(
              color: kTextBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    children: List.generate(widget.imageList.length, (index) {
                      return Stack(
                        children: [
                          Container(
                            color: Colors.red,
                            child: Image.network(widget.imageList[index]),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              icon: SvgPicture.asset("assets/delete.svg"),
                              onPressed: () {
                                widget.imageList.removeAt(index);

                                _deleteImage(widget.id, widget.imageList,
                                    widget.productName, index);

                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Column(
                    children: List.generate(widget.imageList.length, (index) {
                      return Stack(
                        children: [
                          TextFieldWidget(
                            size: size,
                            fieldName: "Color $index",
                            textController: widget.controllers[index],
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () async {
                      DocumentReference products = FirebaseFirestore.instance
                          .collection('products')
                          .doc(widget.id);

                      for (int i = 0; i < widget.imageList.length; i++) {
                        widget.colorStringList.add(widget.controllers[i].text);
                      }

                      try {
                        log(widget.colorStringList.length.toString());
                        await products.update({
                          'colorStringList': widget.colorStringList,
                        });
                        log("Product Updated");
                      } catch (error) {
                        log("Failed to update product: $error");
                      }
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _deleteImage(
    String id, List imageList, String productName, int index) async {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Reference oldRef = storage.ref().child('images/$productName (${index + 1})');
  await oldRef.delete();
  DocumentReference products =
      FirebaseFirestore.instance.collection('products').doc(id);

  return products.update({'networkImageList': imageList}).then((value) {
    log("Image Deleted");
  }).catchError((error) {
    log("Failed to delete image: $error");
  });
}
