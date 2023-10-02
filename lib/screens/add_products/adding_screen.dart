import 'dart:io';
import 'package:admin_gardenia/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_gardenia/bloc/product_bloc/add_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();
  File? pickedImageFile;
  String dropdownValue = 'Indoor';
  final productModel = ProductClass();
  final _priceControllor = TextEditingController();

  final _nameControllor = TextEditingController();

  final _quantityControllor = TextEditingController();

  final _discriptionControllor = TextEditingController();

  // List getDetailsList() {
  //   return [_productname, _price, _quantity, _description];
  // }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  void takeImg() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      pickedImageFile = File(pickedImage.path);
    });
  }

  Future<void> uploadImageToFirebase() async {
    final _validate = _form.currentState!.validate();
    if (!_validate) {
      return;
    }
    _form.currentState!.save();
    // List details = getDetailsList();/
    if (pickedImageFile == null) {
      return;
    }

    try {
      // Get a reference to the storage service
      firebase_storage.Reference storageReference =
          firebase_storage.FirebaseStorage.instance.ref().child(
                'product_images/${DateTime.now().millisecondsSinceEpoch}.jpg',
              );

      // Upload the file to Firebase Storage
      await storageReference.putFile(pickedImageFile!);

      // Get the download URL of the uploaded image
      String downloadURL = await storageReference.getDownloadURL();

      // TODO: Use downloadURL as needed (e.g., save it to a database)

      // Optional: Display a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image uploaded successfully!'),
        ),
      );
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      // Handle errors during the upload process
      print('Error uploading image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error uploading image. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocBuilder<AddProductBloc, AddProductState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<AddProductBloc>(context)
                            .add(AddImageEvent());
                      },
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: pickedImageFile != null
                            ? Image.file(
                                pickedImageFile!,
                                fit: BoxFit.cover,
                              )
                            : Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                  color: Colors.grey[500],
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameControllor,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _priceControllor,
                  decoration: const InputDecoration(
                    labelText: 'Price (\$)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter price';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Select Category',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Indoor',
                      child: Text('Indoor'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Outdoor',
                      child: Text('Outdoor'),
                    ),
                  ],
                  underline: Container(
                    width: 10,
                    height: 1,
                    color: Colors.black,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  value: dropdownValue,
                  onChanged: (String? newvalue) {
                    setState(
                      () {
                        dropdownValue = newvalue!;
                      },
                    );
                  },
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _quantityControllor,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _discriptionControllor,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Discription';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_form.currentState!.validate()) {
                      productModel.description =
                          _discriptionControllor.text.trim();
                      productModel.quantity = _quantityControllor.text.trim();
                      productModel.price = _priceControllor.text.trim();
                      productModel.productname = _nameControllor.text.trim();
                      BlocProvider.of<AddProductBloc>(context).add(
                        FirebaseAddEvent(
                            context: context, product: productModel),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.all(16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
