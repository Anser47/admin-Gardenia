import 'dart:io';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<String> uploadImageToFirebase({required File imageFile}) async {
  // await Firebase.initializeApp();
  try {
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(
              'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
            );

    await storageReference.putFile(imageFile);

    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  } on FirebaseException catch (error) {}
  return 'Empty';
}

Future<void> addProductToFirebase({
  required ProductClass product,
  required String imgUrl,
  required BuildContext? context,
}) async {
  try {
    await FirebaseFirestore.instance.collection('Products').doc(product.id).set(
      {
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
        'description': product.description,
        'category': product.category,
        'imageUrl': imgUrl,
        'id': product.id,
      },
    );
  } on FirebaseFirestore catch (error) {
    showSnackbar(context!, "Failed To Add Product: $error");
    print("============Fail to add Product: $error");
  }
}

void showSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 100.0),
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
