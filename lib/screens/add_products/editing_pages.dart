import 'package:admin_gardenia/bloc/product_bloc/add_product_bloc.dart';
import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageEditScreen extends StatelessWidget {
  const ImageEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 20,
            ),
            CommonButton(name: 'Update new image', voidCallback: () {})
          ],
        ),
      ),
    );
  }
}

class ProductNameEditScreen extends StatelessWidget {
  ProductNameEditScreen({super.key});
  final _nameControllor = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          kSize20,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CommonTextFields(
                inputType: TextInputType.name,
                labelText: 'Productname',
                validator: 'Please Enter Product Name',
                nameControllor: _nameControllor),
          ),
          kSize20,
          CommonButton(name: 'Update new name', voidCallback: () {}),
        ],
      ),
    );
  }
}

class PriceEditScreen extends StatelessWidget {
  PriceEditScreen({super.key});
  final _PriceControllor = TextEditingController();
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
                nameControllor: _PriceControllor),
          ),
          CommonButton(name: 'Update new price', voidCallback: () {})
        ],
      ),
    );
  }
}

class QuantityEditScreen extends StatelessWidget {
  QuantityEditScreen({super.key});
  final _quantityControllor = TextEditingController();

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
          CommonButton(name: 'Update new quantity', voidCallback: () {})
        ],
      ),
    );
  }
}

class CategoryEditScreen extends StatelessWidget {
  const CategoryEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
    );
  }
}

class DiscriptionEditScreen extends StatelessWidget {
  DiscriptionEditScreen({super.key});
  final _discriptionControllor = TextEditingController();

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
              labelText: 'Discription',
              validator: 'Please Enter Product discription',
              nameControllor: _discriptionControllor,
            ),
          ),
          CommonButton(name: 'Update new Discription', voidCallback: () {})
        ],
      ),
    );
  }
}
