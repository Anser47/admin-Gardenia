import 'dart:developer';

import 'package:admin_gardenia/data/product_functions/product_remove.dart';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:admin_gardenia/screens/add_products/adding_screen.dart';
import 'package:admin_gardenia/screens/add_products/editing_screen.dart';
import 'package:admin_gardenia/screens/add_products/product_discription.dart';
import 'package:admin_gardenia/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenAddedProducts extends StatefulWidget {
  ScreenAddedProducts({
    super.key,
  });

  @override
  State<ScreenAddedProducts> createState() => _ScreenAddedProductsState();
}

class _ScreenAddedProductsState extends State<ScreenAddedProducts> {
  CollectionReference productRef =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Add Product',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProductScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: ProductBody(productRef: productRef),
      ),
    );
  }
}

class ProductBody extends StatefulWidget {
  const ProductBody({
    super.key,
    required this.productRef,
  });

  final CollectionReference<Object?> productRef;

  @override
  State<ProductBody> createState() => _ProductBodyState();
}

class _ProductBodyState extends State<ProductBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: StreamBuilder(
              stream: widget.productRef.snapshots(),
              builder: (context, snapshot) {
                List<QueryDocumentSnapshot<Object?>> data = [];
                if (snapshot.data == null) {
                  return const Center(
                    child: Text('Add Products'),
                  );
                }
                data = snapshot.data!.docs;
                if (snapshot.data!.docs.isEmpty || data.isEmpty) {
                  return const Center(
                    child: Text('No Products'),
                  );
                }
                // print(
                //   '--------------------${data.length}',
                // );

                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return AddProductCard(
                      id: data[index]['id'],
                      category: data[index]['category'] ?? 'null data',
                      discription: data[index]['description'] ?? 'null data',
                      price: data[index]['price'] ?? 'null Data',
                      delete: () {
                        deleteProduct(
                          id: data[index].id,
                          context: context,
                        );
                      },
                      edit: () {
                        log('Hello== this is edit');
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ScreenEditing(
                              id: data[index]['id'],
                            );
                          },
                        );
                      },
                      img: data[index]['imageUrl'] ??
                          'https://static.wikia.nocookie.net/black-plasma-studios/images/a/ad/Null_-_Profile.jpg/revision/latest?cb=20170612234434',
                      name: data[index]['name'] ?? 'name',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 25,
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class AddProductCard extends StatefulWidget {
  AddProductCard(
      {super.key,
      required this.name,
      required this.img,
      required this.delete,
      required this.edit,
      required this.price,
      required this.category,
      required this.discription,
      required this.id});
  final String name;
  final String img;
  final String id;
  final String price;
  final String category;
  final String discription;
  VoidCallback edit;
  VoidCallback delete;

  @override
  State<AddProductCard> createState() => _AddProductCardState();
}

class _AddProductCardState extends State<AddProductCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDiscription(
                  id: widget.id,
                  img: widget.img,
                  category: widget.category,
                  discription: widget.discription,
                  name: widget.name,
                  price: widget.price,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 3,
                  width: 340,
                  // decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    widget.img,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(gradient: gcolor),
                  child: ListTile(
                    leading: Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return ScreenEditing(
                                  id: widget.id,
                                );
                              },
                            );
                          },
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () async {
                            _showMyDialog(context: context);
                            // await FirebaseFirestore.instance
                            //     .collection('Products')
                            //     .doc(widget.id)
                            //     .delete();
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog({context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text('Are sure you want to delete'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Products')
                    .doc(widget.id)
                    .delete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

Future<List<ProductClass>> fetchProducts() async {
  try {
    var userCollectionSnapshot =
        await FirebaseFirestore.instance.collection('Products').get();
    return userCollectionSnapshot.docs.map(
      (doc) {
        Map<String, dynamic> data = doc.data();
        return ProductClass.fromJson(data);
      },
    ).toList();
  } catch (e) {
    // print("Error fetching products: $e");
    return [];
  }
}
