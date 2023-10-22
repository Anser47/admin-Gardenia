import 'package:admin_gardenia/bloc/product_bloc/add_product_bloc.dart';
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
            Center(
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
          ],
        ),
      ),
    );
  }
}

class ProductNameEditScreen extends StatelessWidget {
  const ProductNameEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class PriceEditScreen extends StatelessWidget {
  const PriceEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class QuantityEditScreen extends StatelessWidget {
  const QuantityEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class CategoryEditScreen extends StatelessWidget {
  const CategoryEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DiscriptionEditScreen extends StatelessWidget {
  const DiscriptionEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
