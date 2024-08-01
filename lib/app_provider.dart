import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/Model/user_model.dart';
import 'package:foody/constants/constants.dart';
import 'package:foody/firebase_services/firebase_storage.dart';


class AppProvider with ChangeNotifier {

  UserModel? _userModel;

  UserModel get getUserInformation => _userModel!;
  
  User? currentUser;
  DocumentSnapshot<Map<String, dynamic>>? userData;

  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File? file) async {
    if (file == null) {
      showLoaderDialog(context);

      _userModel = userModel;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } else {
      showLoaderDialog(context);

      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(file);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      // ignore: use_build_context_synchronously
      Navigator.of(context, rootNavigator: true).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
    showMessage("Successfully updated profile");

    notifyListeners();
  }
}
