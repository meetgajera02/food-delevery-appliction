import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_provider.dart';
import '../constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SingleCartItem extends StatefulWidget {
  final ProductModel product;
  const SingleCartItem({super.key, required this.product});

  @override
  State<SingleCartItem> createState() => _SingleCartItemState();
}

class _SingleCartItemState extends State<SingleCartItem> {
  int qty = 1;
  User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    qty = widget.product.qty;
  }

  Future<void> updateQty(ProductModel product, int newQty) async {
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('cart')
          .doc(product.id)
          .update({'qty': newQty});
    }
  }

  Future<void> removeFromCart(ProductModel product) async {
    if (currentUser != null) {
      await firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('cart')
          .doc(product.id)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 360,
                      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [BoxShadow(color: Color.fromARGB(255, 243, 243, 243))],
                      ),
                      child: Row(
                        children: [
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          Image.network(widget.product.image, width: 66, height: 66),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(widget.product.name, style: GoogleFonts.josefinSans(fontSize: 22)),
                              Text(widget.product.status, style: GoogleFonts.lato(fontSize: 16, color: const Color.fromRGBO(126, 126, 126, 1))),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      CupertinoButton(
                                        onPressed: () {
                                          if (qty > 1) {
                                            setState(() {
                                              qty--;
                                            });
                                            appProvider.updateQty(widget.product, qty);
                                            updateQty(widget.product, qty);
                                          }
                                        },
                                        padding: EdgeInsets.zero,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          maxRadius: 13,
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      Text('$qty', style: GoogleFonts.lato(fontSize: 18)),
                                      CupertinoButton(
                                        onPressed: () {
                                          setState(() {
                                            qty++;
                                          });
                                          appProvider.updateQty(widget.product, qty);
                                          updateQty(widget.product, qty);
                                        },
                                        padding: EdgeInsets.zero,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.amber,
                                          maxRadius: 13,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 20),
                                  Text("₹ ${qty * widget.product.price}", style: GoogleFonts.lato(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    CupertinoButton(
                      onPressed: () {
                        appProvider.removeCartProduct(widget.product);
                        removeFromCart(widget.product);
                        showMessage("Removed from Cart");
                      },
                      child: const CircleAvatar(
                        backgroundColor: Colors.amber,
                        maxRadius: 13,
                        child: Icon(Icons.delete, size: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
