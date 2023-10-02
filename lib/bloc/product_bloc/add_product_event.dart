part of 'add_product_bloc.dart';

class AddProductEvent {}

class AddImageEvent extends AddProductEvent {}

class FirebaseAddEvent extends AddProductEvent {
  BuildContext context;
  ProductClass product;
  FirebaseAddEvent({required this.context, required this.product});
}
