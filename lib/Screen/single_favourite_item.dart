import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../app_provider.dart';
import '../constants/constants.dart';

class SingleFavouriteItem extends StatefulWidget {
  final ProductModel product;
  const SingleFavouriteItem({super.key, required this.product});

  @override
  State<SingleFavouriteItem> createState() => _SingleFavouriteItemState();
}

class _SingleFavouriteItemState extends State<SingleFavouriteItem> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(
      context,
    );
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                            Image.network(widget.product.image,width: 66,height: 66),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text(widget.product.name,style:GoogleFonts.josefinSans(fontSize:22)),
                                Text("₹  ${widget.product.price}",style:GoogleFonts.lato(fontSize:18)),
                              ]
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            widget.product.isFavourite = !widget.product.isFavourite;
                          });
                          if (widget.product.isFavourite) {
                            appProvider.addFavouriteProduct(widget.product);
                            showMessage("Added to Favourite");
                          } else {
                            appProvider.removeFavouriteProduct(widget.product);
                            showMessage("Remove to Favourite");
                          }
                        }, 
                        icon: Icon(widget.product.isFavourite? Icons.favorite : Icons.favorite_border,color: const Color.fromARGB(255, 255, 200, 58)),
                      )
                    ]
                  ),
                ],
              ),
            )
        ],
      )
    );
  }
}
