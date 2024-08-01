import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/Screen/single_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

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
        title:  Text("Your Cart",style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
      ),
      body: appProvider.getCartProductList.isEmpty
        ? const Center( 
          child: Text("Empty"),
        )
        : ListView.builder(
          itemCount: appProvider.getCartProductList.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (ctx, index) {
            return SingleCartItem(
              product: appProvider.getCartProductList[index],
          );
        }
      ), 
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹ ${appProvider.totalPrice().toString()}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              CupertinoButton(
                color: const Color.fromRGBO(255, 204, 0, 1),
                onPressed: () {}, 
                child: Text("Confirm",style: GoogleFonts.poppins(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}