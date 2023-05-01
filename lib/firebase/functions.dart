import 'dart:developer';

import 'package:amplify/firebase/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addProduct(Products productClass) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  return products
      .add({
        'productName': productClass.productName,
        'brand': productClass.brand,
        'category': productClass.category,
        'description': productClass.description,
        'long description': productClass.longDescription,
        'price': productClass.price,
        'quantity': productClass.quantity,
        'imageString': productClass.imageString,
        'id': products.doc().id,
      })
      .then((value) => log("User Added"))
      .catchError((error) => log("Failed to add user: $error"));
}

Future<void> updateProduct(Products productClass, String id) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  return products
      .doc(id)
      .update({
        'productName': productClass.productName,
        'brand': productClass.brand,
        'category': productClass.category,
        'description': productClass.description,
        'long description': productClass.longDescription,
        'price': productClass.price,
        'quantity': productClass.quantity,
        'imageString': productClass.imageString,
        'id': id,
      })
      .then((value) => log("User Added"))
      .catchError((error) => log("Failed to add user: $error"));
}
