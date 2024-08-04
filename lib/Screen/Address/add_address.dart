import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/Model/address_model.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  User? currentUser = FirebaseAuth.instance.currentUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();

  String? _validateNonEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void _saveAddress() async {
    AddressModel newAddress = AddressModel(
      id: FirebaseFirestore.instance.collection('address').doc().id, 
      name: name.text, 
      phone: phone.text, 
      building: building.text, 
      city: city.text, 
      state: state.text, 
      pinCode: pincode.text, 
      area: area.text,
    );
    await FirebaseFirestore.instance
    .collection('users')
          .doc(currentUser!.uid)
          .collection('address')
          .doc(newAddress.id)
          .set(newAddress.toJson());
    
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Address Saved!')));
      _clearForm();
  }

  void _clearForm() {
    name.clear();
    phone.clear();
    building.clear();
    city.clear();
    state.clear();
    pincode.clear();
    area.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "New Address",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: name,
                  validator: _validateNonEmpty,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: phone,
                  validator: _validateNonEmpty,
                  decoration: InputDecoration(
                    labelText: "Phone number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    )
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 155,
                      child: TextFormField(
                        controller: pincode,
                        validator: _validateNonEmpty,
                        decoration: InputDecoration(
                          labelText: "Pincode",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 155,
                    child: TextFormField(
                      controller: state,
                      validator: _validateNonEmpty,
                      decoration: InputDecoration(
                        labelText: "State",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 155,
                    child: TextFormField(
                      controller: city,
                      validator: _validateNonEmpty,
                      decoration: InputDecoration(
                        labelText: "City",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: building,
                validator: _validateNonEmpty,
                decoration: InputDecoration(
                  labelText: "House No. Building Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: area,
                validator: _validateNonEmpty,
                decoration: InputDecoration(
                  labelText: "Road Name, Area, Colony",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(280, 60),
                  textStyle: const TextStyle(fontSize: 24),
                  backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
                ),
                onPressed: _saveAddress,
                child: const Text("Save",style: TextStyle(color: Colors.black))
              ),
              ],
            )
          ),
        )
      ),
    );
  }
}