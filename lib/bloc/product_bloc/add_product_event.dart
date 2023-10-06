part of 'add_product_bloc.dart';

class AddProductEvent {}

class AddImageEvent extends AddProductEvent {}

class FirebaseAddEvent extends AddProductEvent {
  BuildContext context;
  ProductClass product;
  String uniqueFileName;
  File imageFile;
  FirebaseAddEvent(
      {required this.context,
      required this.product,
      required this.uniqueFileName,
      required this.imageFile});
}
