import 'dart:developer';

import 'package:amplify/firebase/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addProduct(Products productClass, BuildContext context) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  return products.add({
    'productName': productClass.productName,
    'brand': productClass.brand,
    'category': productClass.category,
    'description': productClass.description,
    'long description': productClass.longDescription,
    'price': productClass.price,
    'quantity': productClass.quantity,
    'imageString': productClass.imageString,
    'id': products.doc().id,
  }).then((value) {
    showSnackbar(context, "Product was added");
    log("Product Added");
  }).catchError((error) {
    showSnackbar(context, "Failed to add product: $error");
    log("Failed to add product: $error");
  });
}

Future<void> updateProduct(
    Products productClass, String id, BuildContext context) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  return products.doc(id).update({
    'productName': productClass.productName,
    'brand': productClass.brand,
    'category': productClass.category,
    'description': productClass.description,
    'long description': productClass.longDescription,
    'price': productClass.price,
    'quantity': productClass.quantity,
    'imageString': productClass.imageString,
    'id': id,
  }).then((value) {
    log("Product Updated");
    showSnackbar(context, "Product was updated");
  }).catchError((error) {
    showSnackbar(context, "Failed to update product: $error");
    log("Failed to update product: $error");
  });
}

Future<void> deleteProduct(
    String id, BuildContext context) {
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  return products.doc(id).delete().then((value) {
    log("Product Deleted");
    showSnackbar(context, "Product was deleted");
  }).catchError((error) {
    log("Failed to delete product: $error");
    showSnackbar(context, "Failed to delete product");
  });
}

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
