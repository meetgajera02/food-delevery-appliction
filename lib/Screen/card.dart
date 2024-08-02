import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/Model/product_model.dart';
import 'package:foody/Screen/single_card.dart';
import 'package:google_fonts/google_fonts.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> _fetchCart() async {
    if (currentUser != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('cart')
          .get();

      return querySnapshot.docs
          .map((e) => ProductModel.fromJson(e.data()))
          .toList();
    }
    return [];
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
          "Your Cart",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _fetchCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in cart'));
          }

          List<ProductModel> cart = snapshot.data!;
          return ListView.builder(
            itemCount: cart.length,
            itemBuilder: (ctx, index) {
              ProductModel product = cart[index];
              return SingleCartItem(product: product);
            },
          );
        },
      ),
    );
  }
}
