part of 'add_product_bloc.dart';

class AddProductState {}

class AddImageState extends AddProductState {
  File imagestate;
  AddImageState({required this.imagestate});
}

class AddProductDataState extends AddProductEvent {
  ProductClass productStateObj;
  AddProductDataState({required this.productStateObj});
}
