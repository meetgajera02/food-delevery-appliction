import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}  , 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title:  Text(product.name,style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
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
                      product.image,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(product.name,style:GoogleFonts.lato(fontSize:26)),
                  const SizedBox(height: 20),
                  Text("Rs. ${product.price}",style:GoogleFonts.josefinSans(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("About",style:GoogleFonts.lato(fontSize:22)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(product.description, style:GoogleFonts.poppins(fontSize:16),textAlign: TextAlign.justify),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(00, 45),
                      backgroundColor: const Color.fromRGBO(255, 200, 58, 1),
                    ),
                    onPressed: (){}, 
                    child: SizedBox(
                      width: 200,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset("assets/images/Group.png"),
                          const Text("Add to cart",style: TextStyle(color: Colors.black),),
                          Image.asset("assets/images/Group1.png")
                        ],
                      ),
                    )
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
