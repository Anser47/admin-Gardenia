import 'package:admin_gardenia/screens/home/home.dart';
import 'package:admin_gardenia/screens/orders/order_detiles.dart';
import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:flutter/material.dart';

class CompletedOrders extends StatelessWidget {
  const CompletedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Completed Orders'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              kHeight20,
              OrderStatusCard(
                size: size,
                nav: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const OrderDetiles(),
                  ));
                },
              ),
              OrderStatusCard(
                size: size,
                nav: () {},
              )
            ],
          ),
        ));
  }
}

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({
    super.key,
    required this.size,
    required this.nav,
  });

  final Size size;
  final VoidCallback nav;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          nav();
        },
        child: Card(
          elevation: 9,
          child: Container(
            height: size.height / 7,
            width: double.infinity,
            decoration: const BoxDecoration(gradient: gcolor),
            child: const Center(
              child: ListTile(
                title: Text(
                  'customer@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Order Completed'),
                trailing: Text('View'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
