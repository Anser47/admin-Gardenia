import 'dart:io';

import 'package:admin_gardenia/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<String> uploadImageToFirebase({required File imageFile}) async {
  await Firebase.initializeApp();
  try {
    // Get a reference to the storage service
    firebase_storage.Reference storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child(
              'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
            );

    await storageReference.putFile(imageFile);

    String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Image uploaded successfully!'),
    //   ),
    // );
  } on FirebaseException catch (error) {
    // ScaffoldMessenger.of(context).clearSnackBars();
    // // Handle errors during the upload process
    // print('Error uploading image: $error');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     content: Text('Error uploading image. Please try again.'),
    //   ),
    // );
  }
  return 'Empty';
}

Future<void> addProductToFirebase({
  required ProductClass product,
  required String imgUrl,
  BuildContext? context,
  required String uniqueFileName,
}) async {
  await FirebaseFirestore.instance
      .collection('Products')
      .doc(uniqueFileName)
      .set({
    'name': product.name,
    'price': product.price,
    'quantity': product.quantity,
    'description': product.description,
    'category': product.category,
    'imageUrl': imgUrl,
    'id': uniqueFileName,
  });
}
