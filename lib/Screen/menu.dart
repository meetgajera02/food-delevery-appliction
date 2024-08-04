import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/product_List.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/constants/image.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<Map<String, String>> categories = [
    {'name': 'Pizza', 'image': pizza},
    {'name': 'Fastfood', 'image': fastfood},
    {'name': 'Gujarati', 'image': gujarati},
    {'name': 'Panjabi', 'image': panjabi},
    {'name': 'Chinese', 'image': chinese},
    {'name': 'South', 'image': south},
    {'name': 'Drinks', 'image': drink},
    {'name': 'Juice', 'image': juice},
    {'name': 'Desserts', 'image': dessert},
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "Our Menu",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: 100,
                width: 100,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  categories.isEmpty
                      ? Center(
                          child: Text(
                            "Best Product is empty",
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return CupertinoButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductList(
                                          category: categories[index]['name']!),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 220,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        categories[index]['image']!,
                                        height: 120,
                                        width: 150,
                                      ),
                                      Text(
                                        categories[index]['name']!,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            );
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
