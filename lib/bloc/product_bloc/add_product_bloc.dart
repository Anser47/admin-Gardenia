import 'dart:io';

import 'package:admin_gardenia/data/product_functions/image_picker.dart';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState()) {
    on<AddImageEvent>((event, emit) async {
      final imgPath = await takeImg();
      emit(
        AddImageState(imagestate: imgPath),
      );
    });
    on<FirebaseAddEvent>((event, emit) async {
      Future<void> addProductToFirebase(
          {required ProductClass product, BuildContext? context}) async {}
    });
  }
}
