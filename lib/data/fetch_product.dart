import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  CollectionReference productreference =
      FirebaseFirestore.instance.collection('product');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Products').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // If there is no error and data is available, display the product list
        var products = snapshot.data!.docs;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            var product = products[index].data() as Map<String, dynamic>;
            return ProductCard(
              name: product['name'],
              price: product['price'],
              quantity: product['quantity'],
              description: product['description'],
              category: product['category'],
              imageUrl: product['imageUrl'],
            );
          },
        );
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String category;
  final String imageUrl;

  ProductCard({
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          imageUrl,
          width: 50.0,
          height: 50.0,
          fit: BoxFit.cover,
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${price.toString()}'),
            Text('Quantity: $quantity'),
            Text('Category: $category'),
            Text('Description: $description'),
          ],
        ),
      ),
    );
  }
}
