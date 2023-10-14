import 'dart:io';

import 'package:admin_gardenia/data/product_functions/image_picker.dart';
import 'package:admin_gardenia/data/product_functions/product_adding_function.dart';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:admin_gardenia/screens/add_products/added_products.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'add_product_event.dart';
part 'add_product_state.dart';

CollectionReference reference =
    FirebaseFirestore.instance.collection('shopping_list');

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState()) {
    on<AddImageEvent>(
      (event, emit) async {
        final imgPath = await takeImg();
        emit(
          AddImageState(imagestate: imgPath),
        );
      },
    );
    on<FirebaseAddEvent>(
      (event, emit) async {
        final imgUrl = await uploadImageToFirebase(imageFile: event.imageFile);
        await addProductToFirebase(
          imgUrl: imgUrl,
          product: event.product,
          context: event.context,
        );
        emit(
          AddProductDataState(productStateObj: event.product)
              as AddProductState,
        );
      },
    );
    on<FirebaseProductEvent>((event, emit) async {
      List<ProductClass> products = fetchProducts() as List<ProductClass>;
      emit(FirebaseProductState(listProduct: products));
    });
  }
}
