import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../Model/product_model.dart';

class DataEntryPage extends StatefulWidget {
  @override
  _DataEntryPageState createState() => _DataEntryPageState();
}

class _DataEntryPageState extends State<DataEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  String? _selectedCategory;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();

  final List<String> _categories = ['Pizza', 'Fastfood','Gujarati','Panjabi','Chinese','South', 'Drinks','Juise', 'Desserts'];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<String> _uploadImage(XFile image) async {
    final storageRef = FirebaseStorage.instance.ref().child('product_images/${image.name}');
    await storageRef.putFile(File(image.path));
    return await storageRef.getDownloadURL();
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate() && _selectedCategory != null && _image != null) {
      final imageUrl = await _uploadImage(_image!);

      ProductModel newProduct = ProductModel(
        id: FirebaseFirestore.instance.collection('products').doc().id,
        name: _nameController.text,
        description: _descriptionController.text,
        image: imageUrl,
        price: double.parse(_priceController.text),
        isFavourite: false,
        status: 'Available',
        qty: int.parse(_qtyController.text),
      );

      await FirebaseFirestore.instance
          .collection('categories')
          .doc(_selectedCategory)
          .collection('products')
          .doc(newProduct.id)
          .set(newProduct.toJson());

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product Saved!')));
      _clearForm();
    }
  }

  void _clearForm() {
    _nameController.clear();
    _descriptionController.clear();
    _priceController.clear();
    _qtyController.clear();
    setState(() {
      _selectedCategory = null;
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _qtyController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              _image == null
                  ? TextButton(
                      onPressed: _pickImage,
                      child: Text('Select Image'),
                    )
                  : Image.file(File(_image!.path), height: 150),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
