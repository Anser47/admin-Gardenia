import 'package:flutter/material.dart';

class OrderDetiles extends StatefulWidget {
  const OrderDetiles({super.key});

  @override
  State<OrderDetiles> createState() => _OrderDetilesState();
}

class _OrderDetilesState extends State<OrderDetiles> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.grey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: size.height / 14,
                child: const Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 8),
                  child: Text(
                    'Order Id : OND049U57797582',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: size.height / 5,
                child: Center(
                  child: ListTile(
                    title: const Text('Snake Plant'),
                    subtitle: const Text('Customer: customer@gmail.com'),
                    trailing: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset('lib/assets/2.png'),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
