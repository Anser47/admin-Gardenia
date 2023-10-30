import 'package:admin_gardenia/screens/home/home.dart';
import 'package:admin_gardenia/widget/common_widget.dart';
import 'package:flutter/material.dart';

class ScreenStocks extends StatelessWidget {
  const ScreenStocks({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Avilable',
                icon: Icon(Icons.event_available),
              ),
              Tab(
                text: 'Out of Stock',
                icon: Icon(Icons.shopping_bag),
              ),
            ],
          ),
          title: const Text('Stocks'),
        ),
        body: TabBarView(children: [
          Container(
            decoration: const BoxDecoration(gradient: gcolor),
            child: Column(
              children: [
                kHeight20,
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: size.height / 5,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.6IeEzE8WjRisNJks_ytv-AHaJO%26pid%3DApi&f=1&ipt=41acb58a3b29bc0977c9f208e79bd3319dd0788e2b8f14f1917f68b5d6fbfed4&ipo=images',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // Product Details
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product Name',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Price: ₹99',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Quantity : '),
                                    Text(' 3'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Text('Empty'),
            ),
          ),
        ]),
      ),
    );
  }
}
