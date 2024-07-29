import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Model/product_model.dart';
import 'package:foody/firebase_services/firebase_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    productModelList = await FirebaseFirestoreHelper.instance.menu();
    //productModelList.shuffle();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context, false), 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title:  Text("Our Menu",style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
      ),
      body: isLoading? Center(
        child: Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
            ),
            productModelList.isEmpty ? const Center(
              child: Text("Best Product is empty"),
            ):GridView.builder(
              scrollDirection:  Axis.vertical,
              shrinkWrap: true,
              itemCount: productModelList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (ctx,index) {
                ProductModel singleProduct = productModelList[index];
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CupertinoButton(
                    onPressed: (){},
                    child: SizedBox(
                      child: Column(
                        children: [
                          Image.network(singleProduct.image,width: 50,height: 50),
                          Text (singleProduct.name,style:GoogleFonts.lato(fontSize:22,color: Colors.black))
                        ]
                      ),
                    )
                  )
                );
              }
            )
          ],
        ),
      ),
    );
  }
}