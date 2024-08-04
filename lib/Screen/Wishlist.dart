import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/Model/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> _fetchWishlist() async {
    if (currentUser != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('wishlist')
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
          "Your Wishlist",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _fetchWishlist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No items in wishlist'));
          }

          List<ProductModel> wishlist = snapshot.data!;
          return ListView.builder(
            itemCount: wishlist.length,
            itemBuilder: (ctx, index) {
              ProductModel product = wishlist[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 262,
                          height:100,
                          margin: const EdgeInsets.symmetric(horizontal: 3,vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: const [BoxShadow(
                              color: Color.fromARGB(255, 243, 243, 243),
                            )]
                          ),
                          child: Row(
                            children: [
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                              Image.network(product.image,width: 66,height: 66),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(product.name,style:GoogleFonts.josefinSans(fontSize:22)),
                                  Text("₹  ${product.price}",style:GoogleFonts.lato(fontSize:18)),
                                ]
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await firestore
                              .collection('users')
                              .doc(currentUser!.uid)
                              .collection('wishlist')
                              .doc(product.id)
                              .delete();
                            setState(() {});
                          },
                          icon: Icon(product.isFavourite? Icons.favorite_border : Icons.favorite,color: const Color.fromARGB(255, 255, 200, 58)),
                        )
                      ]
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
