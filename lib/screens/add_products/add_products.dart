import 'package:admin_gardenia/screens/add_products/adding_screen.dart';
import 'package:admin_gardenia/screens/home/home.dart';
import 'package:flutter/material.dart';

class ScreenAddProduct extends StatelessWidget {
  const ScreenAddProduct({
    super.key,
  });

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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddProductScreen(),
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
          child: Container(
            decoration: const BoxDecoration(gradient: gcolor),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return AddProductCard(
                        delete: () {},
                        edit: () {},
                        img: Image.network(''),
                        name: 'Peace lily',
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 25,
                      );
                    },
                  ),
                ),
              ],
            ),
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
      required this.edit});
  final String name;
  final Image img;
  VoidCallback edit;
  VoidCallback delete;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          width: 340,
          decoration: const BoxDecoration(color: Colors.amber),
          child: Image.network(
            'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.OaSiQ8I9ONIpL9Vbe-T2_gHaE8%26pid%3DApi&f=1&ipt=284fd452abd88ab83e557f9223f7e4295885fccc3a95df40bc098baee9b3d09c&ipo=images',
            fit: BoxFit.cover,
          ),
        ),
        Container(
            height: 60,
            width: 340,
            decoration: const BoxDecoration(color: Colors.white),
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
            )),
      ],
    );
  }
}
