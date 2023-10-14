import 'package:admin_gardenia/sample.dart';
import 'package:admin_gardenia/screens/add_products/added_products.dart';
import 'package:admin_gardenia/screens/auth/auth.dart';
import 'package:admin_gardenia/screens/earnings/earnings.dart';
import 'package:admin_gardenia/screens/orders/orders.dart';
import 'package:admin_gardenia/screens/total_stocks.dart/total_stocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  List<Widget> _screens = [
    ScreenAddedProducts(),
    ScreenEarnings(),
    ScreenStocks(),
    OrdersScreen(),
  ];
  final List<String> _screenName = [
    'Add product',
    'Earnings',
    'Avilable Stocks',
    'Orders'
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Choose What you want',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                firebase.signOut();
              },
              icon: const Icon(Icons.logout_sharp),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  const cardWidth = 200.0;
                  const cardHeight = 150.0;

                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: 4,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: cardWidth / cardHeight,
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 13.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, index) {
                      return AdminCard(
                        cardWidth: cardWidth,
                        cardHeight: cardHeight,
                        name: _screenName[index],
                        navigator: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => _screens[index]),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  AdminCard(
      {super.key,
      required this.cardWidth,
      required this.cardHeight,
      required this.navigator,
      required this.name});
  VoidCallback navigator;
  final double cardWidth;
  final double cardHeight;
  final String name;
  @override
  Widget build(BuildContext context) {
    getData();
    return GestureDetector(
      onTap: navigator,
      child: Card(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: const BoxDecoration(gradient: gcolor),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

const LinearGradient gcolor = LinearGradient(colors: [
  Color.fromARGB(255, 109, 219, 236),
  Color.fromARGB(255, 162, 245, 175),
], begin: Alignment.topLeft);
