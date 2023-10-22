import 'dart:io';

import 'package:admin_gardenia/screens/add_products/commom.dart';
import 'package:admin_gardenia/screens/add_products/editing_pages.dart';
import 'package:flutter/material.dart';

class ScreenEditing extends StatefulWidget {
  ScreenEditing({super.key});

  @override
  State<ScreenEditing> createState() => _ScreenEditingState();
}

class _ScreenEditingState extends State<ScreenEditing> {
  final _form = GlobalKey<FormState>();

  File? pickedImageFile;
  final kSize = SizedBox(
    height: 20,
  );
  String dropdownValue = 'Indoor';

  final _priceControllor = TextEditingController();

  final _nameControllor = TextEditingController();

  final _quantityControllor = TextEditingController();

  final _discriptionControllor = TextEditingController();

  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  late File? path;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(
                name: 'Image',
                voidCallback: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageEditScreen(),
                    ),
                  );
                }),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(name: 'Product Name', voidCallback: () {}),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(name: 'Price', voidCallback: () {}),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(name: 'Quantity', voidCallback: () {}),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(name: 'Category', voidCallback: () {}),
          ),
          kSize,
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: CommonButton(name: 'Discription', voidCallback: () {}),
          ),
        ],
      ),
    );
  }
}
// Column(
//         children: [
//           Form(
//             key: _form,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     GestureDetector(
//                       onTap: () {},
//                       child: Container(
//                         height: 200,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(12.0),
//                         ),
//                         child: Center(
//                           child: Icon(
//                             Icons.add_a_photo,
//                             size: 40,
//                             color: Colors.grey[500],
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextFormField(
//                       controller: _nameControllor,
//                       decoration: const InputDecoration(
//                         labelText: 'Product Name',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: _priceControllor,
//                       decoration: const InputDecoration(
//                         labelText: 'Price (₹)',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter price';
//                         }

//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     const Text(
//                       'Select Category',
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                     DropdownButton<String>(
//                       items: const [
//                         DropdownMenuItem<String>(
//                           value: 'Indoor',
//                           child: Text('Indoor'),
//                         ),
//                         DropdownMenuItem<String>(
//                           value: 'Outdoor',
//                           child: Text('Outdoor'),
//                         ),
//                       ],
//                       underline: Container(
//                         width: 10,
//                         height: 1,
//                         color: Colors.black,
//                       ),
//                       icon: const Icon(Icons.arrow_drop_down),
//                       value: dropdownValue,
//                       onChanged: (String? newvalue) {
//                         setState(
//                           () {
//                             dropdownValue = newvalue!;
//                           },
//                         );
//                       },
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: _quantityControllor,
//                       decoration: const InputDecoration(
//                         labelText: 'Quantity',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter Quantity';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 12),
//                     TextFormField(
//                       controller: _discriptionControllor,
//                       maxLines: 4,
//                       decoration: const InputDecoration(
//                         labelText: 'Description',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter Discription';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () async {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         padding: const EdgeInsets.all(16),
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                       child: const Text('Add Product'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),