import 'dart:io';

import 'package:admin_gardenia/bloc/product_bloc/add_product_bloc.dart';
import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageEditScreen extends StatelessWidget {
  ImageEditScreen({super.key});
  File? pickedImageFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: Column(
          children: [
            kHeight20,
            Center(
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.3,
                width: MediaQuery.sizeOf(context).width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<AddProductBloc>(context)
                        .add(AddImageEvent());
                  },
                  child: BlocBuilder<AddProductBloc, AddProductState>(
                    builder: (context, state) {
                      if (state is AddImageState) {
                        return Image.file(
                          state.imagestate,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Center(
                          child: Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey[500],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            kHeight20,
            // CommonButton(name: 'Update new image', voidCallback: () {}),
          ],
        ),
      ),
    );
  }
}

/*================name====================== */
class ProductNameEditScreen extends StatelessWidget {
  ProductNameEditScreen({super.key, required this.id});
  final String id;
  final _nameControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          kHeight20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFields(
                inputType: TextInputType.name,
                labelText: 'Productname',
                validator: 'Please Enter Product Name',
                nameControllor: _nameControllor),
          ),
          kHeight20,
          CommonButtonTwo(
            change: _nameControllor.text,
            id: id,
            name: 'Update new name',
            voidCallback: () {
              FirebaseFirestore.instance.collection('Products').doc(id).update({
                'name': _nameControllor.text.trim(),
              });
            },
          ),
        ],
      ),
    );
  }
}

/*================Price====================== */
class PriceEditScreen extends StatelessWidget {
  PriceEditScreen({super.key, required this.id});
  final _priceControllor = TextEditingController();
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommonTextFields(
                inputType: TextInputType.number,
                labelText: 'Price',
                validator: 'Please Enter Product Price',
                nameControllor: _priceControllor),
          ),
          CommonButtonTwo(
              name: 'Update new price',
              voidCallback: () {
                FirebaseFirestore.instance
                    .collection('Products')
                    .doc(id)
                    .update({
                  'price': _priceControllor.text.trim(),
                });
              })
        ],
      ),
    );
  }
}

/*================Quantity====================== */
class QuantityEditScreen extends StatelessWidget {
  QuantityEditScreen({super.key, required this.id});
  final _quantityControllor = TextEditingController();
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommonTextFields(
                inputType: TextInputType.number,
                labelText: 'Quantity',
                validator: 'Please Enter Product Quantity',
                nameControllor: _quantityControllor),
          ),
          CommonButtonTwo(
              name: 'Update new quantity',
              voidCallback: () {
                FirebaseFirestore.instance
                    .collection('Products')
                    .doc(id)
                    .update({
                  'quantity': _quantityControllor.text.trim(),
                });
              })
        ],
      ),
    );
  }
}

/*===================Category=================== */
class CategoryEditScreen extends StatelessWidget {
  const CategoryEditScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
    );
  }
}

/*===================Discription=================== */
class DescriptionEditScreen extends StatelessWidget {
  DescriptionEditScreen({super.key, required this.id});
  final _discriptionControllor = TextEditingController();
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommonTextFields(
              inputType: TextInputType.number,
              labelText: 'Description',
              validator: 'Please Enter Product discription',
              nameControllor: _discriptionControllor,
            ),
          ),
          CommonButtonTwo(
              name: 'Update new Discription',
              voidCallback: () {
                FirebaseFirestore.instance
                    .collection('Products')
                    .doc(id)
                    .update({
                  'description': _discriptionControllor.text.trim(),
                });
              })
        ],
      ),
    );
  }
}
