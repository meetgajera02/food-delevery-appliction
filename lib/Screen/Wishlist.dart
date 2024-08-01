// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/Screen/single_favourite_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_provider.dart';



class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));}  , 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title:  Text("Your Wishes",style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
      ),
       body:  
            appProvider.getFavouriteProductList.isEmpty
          ? const Center(
              child: Text("Empty"),
            )
          : ListView.builder(
              itemCount: appProvider.getFavouriteProductList.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (ctx, index) {
                return SingleFavouriteItem(
                  product: appProvider.getFavouriteProductList[index],
                );
              }),
    );
  }
}