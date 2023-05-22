import 'dart:developer';

import 'package:amplify/firebase/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> addProduct(Products productClass, BuildContext context) async {
  final products = FirebaseFirestore.instance.collection('products');
  final reference = products.doc();
  try {
    showSnackbar(context, "Product was added");
    await reference.set({
      'productName': productClass.productName,
      'brand': productClass.brand,
      'category': productClass.category,
      'description': productClass.description,
      'long description': productClass.longDescription,
      'price': productClass.price,
      'actualPrice': productClass.actualPrice,
      'quantity': productClass.quantity,
      'networkImageList': productClass.networkImageList,
      'id': reference.id,
    });
    log("Product Added");
  } catch (error) {
    showSnackbar(context, "Failed to add product: $error");
    log("Failed to add product: $error");
  }
}

Future<void> updateProduct(
    Products productClass, String id, BuildContext context) async {
  final products = FirebaseFirestore.instance.collection('products');
  final productRef = products.doc(id);
  try {
    showSnackbar(context, "Product was updated");
    await productRef.update({
      'productName': productClass.productName,
      'brand': productClass.brand,
      'category': productClass.category,
      'description': productClass.description,
      'long description': productClass.longDescription,
      'price': productClass.price,
      'actualPrice': productClass.actualPrice,
      'quantity': productClass.quantity,
      'networkImageList': productClass.networkImageList,
    });
    log("Product Updated");
  } catch (error) {
    showSnackbar(context, "Failed to update product: $error");
    log("Failed to update product: $error");
  }
}

Future<void> addMoreImage(List imageList, String id) async {
  final products = FirebaseFirestore.instance.collection('products');
  final productRef = products.doc(id);
  try {
    // showSnackbar(context, "Product was updated");
    await productRef.update({
      'networkImageList': imageList,
    });
    log("Product Updated");
  } catch (error) {
    // showSnackbar(context, "Failed to update product: $error");
    log("Failed to update product: $error");
  }
}

Future<void> deleteProduct(String id, BuildContext context) {
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

Future<void> updateOrderStatus(
    String id, BuildContext context, int orderStatusIndex) async {
  final email = FirebaseAuth.instance.currentUser!.email;
  final products = FirebaseFirestore.instance.collection('orders');
  final productRef = products.doc(id);
  try {
    // showSnackbar(context, "Product was updated");
    await productRef.update({
      'orderStatusIndex': orderStatusIndex,
    });
    log("Product Updated");
  } catch (error) {
    showSnackbar(context, "Failed to update product: $error");
    log("Failed to update product: $error");
  }
}
