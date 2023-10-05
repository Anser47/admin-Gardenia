import 'dart:io';

import 'package:admin_gardenia/data/product_functions/image_picker.dart';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

CollectionReference reference =
    FirebaseFirestore.instance.collection('shopping_list');

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState()) {
    on<AddImageEvent>((event, emit) async {
      final imgPath = await takeImg();
      emit(
        AddImageState(imagestate: imgPath),
      );
    });
    on<FirebaseAddEvent>(
      (event, emit) async {
        Future<void> addProductToFirebase(
            {required ProductClass product, BuildContext? context}) async {
          Map<String, String> dataToSend = {
            'name': product.productname.toString(),
            'price': product.price.toString(),
            'quantity': product.quantity.toString(),
            'description': product.description.toString(),
            'category': product.dropdownValue.toString(),
          };
          reference.add(dataToSend);
          print('callledlllllllllllll');
        }

        emit(AddProductState());
      },
    );
  }
}

// Future<void> addToFirebase({required ProductClass producModel}) async {
//   await FirebaseFirestore.instance.collection('users').doc('Product List').set({
//     'name': productModel.productname,
//     'price': productModel.price,
//     'quantity': productModel.quantity,
//     'description': productModel.description,
//     'category': productModel.dropdownValue,
//   });
// }
