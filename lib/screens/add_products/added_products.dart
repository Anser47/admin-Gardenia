import 'package:admin_gardenia/models/product_model.dart';
import 'package:admin_gardenia/screens/add_products/adding_screen.dart';
import 'package:admin_gardenia/screens/add_products/product_discription.dart';
import 'package:admin_gardenia/screens/home/home.dart';
import 'package:admin_gardenia/widget/shimmer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenAddedProducts extends StatelessWidget {
  ScreenAddedProducts({
    super.key,
  });
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: StreamBuilder(
                  stream: productRef.snapshots(),
                  builder: (context, snapshot) {
                    List<QueryDocumentSnapshot<Object?>> data = [];
                    if (snapshot.data == null) {
                      const Center(
                        child: Text('Add Products'),
                      );
                    }
                    data = snapshot.data!.docs;
                    if (snapshot.data!.docs.isEmpty || data.isEmpty) {
                      return const Center(
                        child: Text('No Products'),
                      );
                    }
                    print('--------------------${data.length}');
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return AddProductCard(
                          category: data[index]['category'] ?? 'null data',
                          discription:
                              data[index]['description'] ?? 'null data',
                          price: data[index]['price'] ?? 'null Data',
                          delete: () {},
                          edit: () {},
                          img: data[index]['imageUrl'] ??
                              'https://plugins.jetbrains.com/files/12562/386947/icon/pluginIcon.png',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddProductCard extends StatelessWidget {
  AddProductCard(
      {super.key,
      required this.name,
      required this.img,
      required this.delete,
      required this.edit,
      required this.price,
      required this.category,
      required this.discription});
  final String name;
  final String img;
  final String price;
  final String category;
  final String discription;
  VoidCallback edit;
  VoidCallback delete;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDiscription(
                  img: img,
                  category: category,
                  discription: discription,
                  name: name,
                  price: price,
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: 340,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: Image.network(
                    img,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 60,
                  width: 340,
                  decoration: const BoxDecoration(gradient: gcolor),
                  child: ListTile(
                    leading: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () {},
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
    print("Error fetching products: $e");
    return [];
  }
}
