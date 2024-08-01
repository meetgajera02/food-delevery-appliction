import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';



// ignore: camel_case_types
class update extends StatefulWidget {
  const update({super.key});

  @override
  State<update> createState() => _updateState();
}

// ignore: camel_case_types
class _updateState extends State<update> {
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  User? currentUser;
  bool isLoading = true;
  File? image;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          currentUser = user;
          email.text = user.email ?? '';
        });

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            name.text = snapshot.data()?['name'] ?? '';
            phone.text = snapshot.data()?['phone'] ?? '';
            email.text = snapshot.data()?['email'] ?? '';
            imageUrl = snapshot.data()?['imageUrl'] ?? '';
          });
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateProfile() async {
    try {
      if (currentUser != null) {
        // Update Firestore with new user data
        await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
          'name': name.text,
          'phone': phone.text,
          'email': email.text,
          'imageUrl': imageUrl,
        });

        if (email.text != currentUser!.email) {
          // ignore: deprecated_member_use
          await currentUser!.updateEmail(email.text);
        }
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e')),
      );
    }
  }

  Future<void> takePicture() async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 40,
      );
      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });

        // Upload the image to Firebase Storage
        String fileName = '${currentUser!.uid}_profile.jpg';
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(fileName)
            .putFile(image!);
        
        String downloadUrl = await uploadTask.ref.getDownloadURL();
        
        // Update the imageUrl in the state and Firestore
        setState(() {
          imageUrl = downloadUrl;
        });

        await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
          'imageUrl': downloadUrl,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated successfully')),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking or uploading image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          child: imageUrl != null && imageUrl!.isNotEmpty
                              ? Image.network(imageUrl!)
                              : Image.asset('assets/images/meet.JPG'),
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
                            onPressed: takePicture,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
              const SizedBox(height: 20),
                  
              TextFormField(
                controller: phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
              ),
               const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
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
                onPressed: updateProfile,
                child: const Text("Save",style: TextStyle(color: Colors.black))
              ),
            ]
          ),
        ),
      ),
    );
  }
}