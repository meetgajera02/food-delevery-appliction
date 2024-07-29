import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foody/Model/user_model.dart';
import 'package:foody/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../app_provider.dart';


// ignore: camel_case_types
class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

// ignore: camel_case_types
class _updateState extends State<update> {
  File? image;
  void takePicture() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children:[
              Container(
                height: 70,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: ()=> Navigator.pop(context, false), 
                    icon: const Icon(Icons.arrow_back_ios,)
                  ),
                  Text("Update",style:GoogleFonts.josefinSans(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children:[
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset('assets/images/meet.JPG')
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.yellow),
                          child:  IconButton(
                            onPressed: (){},
                            icon: const Icon(Icons.add_a_photo,size: 20),color: Colors.black87)
                        ),
                      )
                    ]
                  ),
                ]
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: name,
                    decoration: InputDecoration(
                      hintText: appProvider.getUserInformation.name,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      hintText: appProvider.getUserInformation.phone,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: appProvider.getUserInformation.email,
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
                    onPressed: () async {
                  UserModel userModel = appProvider.getUserInformation.copyWith(name: name.text,phone: phone.text);
                  appProvider.updateUserInfoFirebase(context, userModel, image);
                  showMessage("Successfully update name");
                },
                child: const Text("Save",style: TextStyle(color: Colors.black))
              ),
            ]
          ),
        ),
      ),
    );
  }
}