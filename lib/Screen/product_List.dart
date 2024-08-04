import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/Model/product_model.dart';
import 'package:foody/Screen/product_detail.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductList extends StatelessWidget {
  final String category;

  const ProductList({super.key, required this.category});

  Future<List<ProductModel>> _fetchProducts(String category) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('categories')
            .doc(category)
            .collection('products')
            .get();
    return querySnapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}  , 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title: Text(category,style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0)))
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: _fetchProducts(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          List<ProductModel> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(product: products[index]),
                      ),
                    );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(
                          color: Color.fromARGB(255, 217, 215, 215),
                          blurRadius: 10,
                        ),],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset("assets/images/veg-icon.png",width: 15,height: 15),
                                  Text(products[index].name,style:GoogleFonts.poppins(fontSize:20,color: Colors.black)),
                                  Text(products[index].status,style:GoogleFonts.poppins(fontSize:14,color:const Color.fromRGBO(126, 126, 126, 1))),
                                  Text("₹ ${products[index].price}",style:GoogleFonts.lato(fontSize:20,color: Colors.black)),
                                ],
                              ),
                              const Spacer(),
                              Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                                children: [Image.network(products[index].image,width: 123,height: 123)]
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
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
                                  Text("Add to cart",style:GoogleFonts.poppins(color: Colors.black),),
                                  Image.asset("assets/images/Group1.png")
                                ],
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                );
            },
          );
        },
      ),
    );
  }
}