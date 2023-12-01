import 'dart:io';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
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
        'searchName': product.searchName,
      },
    );
  } on FirebaseException catch (error) {
    String errorMessage = 'An error occurred while adding the product.';

    if (error.code == 'permission-denied') {
      errorMessage =
          'Permission denied. You do not have the necessary permissions.';
    } else if (error.code == 'not-found') {
      errorMessage = 'The requested document was not found.';
    }

    showSnackbar(context!, errorMessage);
    print("Failed to add product: $error");
  } catch (error) {
    // Handle generic exceptions, e.g., network issues
    showSnackbar(context!, 'An unexpected error occurred. Please try again.');
    print("Failed to add product: $error");
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
