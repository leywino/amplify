import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/colors.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen(
      {super.key,
      required this.imageList,
      required this.id,
      required this.productName});

  final List imageList;
  final String id;
  final String productName;

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends State<EditImageScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            GridView.count(
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
  log(index.toString());
  await oldRef.delete();
  DocumentReference products =
      FirebaseFirestore.instance.collection('products').doc(id);

  return products.update({'networkImageList': imageList}).then((value) {
    log("Image Deleted");
  }).catchError((error) {
    log("Failed to delete image: $error");
  });
}
