import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';
import 'package:foody/app_provider.dart';
import 'package:foody/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel product;
  const ProductDetail({super.key, required this.product});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _addToCart(ProductModel product) async {
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('cart')
          .doc(product.id)
          .set(product.toJson());
    }
  }

  Future<void> _addToWishlist(ProductModel product) async {
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('wishlist')
          .doc(product.id)
          .set(product.toJson());
    }
  }

  Future<void> _removeFromWishlist(ProductModel product) async {
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('wishlist')
          .doc(product.id)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,),
        ),
        title: Text(widget.product.name, style: GoogleFonts.poppins(fontSize: 22, color: const Color.fromARGB(255, 178, 125, 0))),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                widget.product.isFavourite = !widget.product.isFavourite;
              });
              if (widget.product.isFavourite) {
                appProvider.addFavouriteProduct(widget.product);
                await _addToWishlist(widget.product);
                showMessage("Added to Favourite");
              } else {
                appProvider.removeFavouriteProduct(widget.product);
                await _removeFromWishlist(widget.product);
                showMessage("Removed from Favourite");
              }
            },
            icon: Icon(widget.product.isFavourite ? Icons.favorite : Icons.favorite_border, color: const Color.fromARGB(255, 255, 200, 58)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Center(
                    child: Image.network(
                      widget.product.image,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(widget.product.name, style: GoogleFonts.lato(fontSize: 26)),
                  const SizedBox(height: 20),
                  Text("Rs. ${widget.product.price}", style: GoogleFonts.josefinSans(fontSize: 22, color: const Color.fromARGB(255, 178, 125, 0))),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("About", style: GoogleFonts.lato(fontSize: 22)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(widget.product.description, style: GoogleFonts.poppins(fontSize: 16), textAlign: TextAlign.justify),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(00, 45),
                      backgroundColor: const Color.fromRGBO(255, 200, 58, 1),
                    ),
                    onPressed: () async {
                      appProvider.addCartProduct(widget.product);
                      await _addToCart(widget.product);
                      showMessage("Added to Cart");
                    },
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/images/Group.png"),
                          Text("Add to cart", style: GoogleFonts.poppins(color: Colors.black)),
                          Image.asset("assets/images/Group1.png")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
