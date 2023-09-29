import 'dart:io';

import 'package:admin_gardenia/data/product_functions/image_picker.dart';
import 'package:bloc/bloc.dart';

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
  }
}
