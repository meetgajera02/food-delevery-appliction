import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/product_List.dart';
import 'package:foody/Screen/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  final List<String> categories = ['Pizza', 'Burgers','Dosa','Chinese', 'Drinks', 'Desserts'];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));}  , 
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
            categories.isEmpty ? Center(
              child: Text("Best Product is empty",style:GoogleFonts.poppins()),
            ):GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection:  Axis.vertical,
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductList(category: categories[index]),
                        ),
                      );
                    },
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text (categories[index],style:GoogleFonts.lato(fontSize:22,color: Colors.black))
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