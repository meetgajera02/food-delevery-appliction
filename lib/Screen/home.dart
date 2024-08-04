import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/Wishlist.dart';
import 'package:foody/Screen/card.dart';
import 'package:foody/Screen/menu.dart';
import 'package:foody/Screen/profile/proflie.dart';
import 'package:foody/constants/image.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // ignore: unused_field
  String _searchText = '';

  User? currentUser;
  DocumentSnapshot<Map<String, dynamic>>? userData;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  final List<Widget> _pages = [
    AdPage(image: 'assets/images/Rectangle.png'),
    AdPage(image: fastfood),
    AdPage(image: drink),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          currentUser = user;
        });

        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          userData = snapshot;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching user data: $e");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                height:50,
              ),
              Row(
                children: [
                  Image.asset(logo,width: 48,height: 48),
                  const SizedBox( width: 10),
                  Text("Foody World",
                    style:GoogleFonts.luckiestGuy(fontSize: 20)
                  ),
                  const Spacer(),
                  Builder(
                    builder: (context) {
                      return IconButton(
                        icon: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(user,width: 48,height: 48)
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _searchText = value.toLowerCase();
                  });
                },
                style: GoogleFonts.poppins(),
                decoration:  InputDecoration(
                  labelStyle: GoogleFonts.poppins(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Food,drinks or brownie...",
                )
              ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _pages[index];
                  },
                ),
              ),
              const SizedBox(height:20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CupertinoButton(
                      onPressed: (){},
                      child: Container(
                        width: 80,
                        height:100,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                        child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(burgericon),
                              Text("Burger",style:GoogleFonts.josefinSans(fontSize:16,color: Colors.black))
                            ],
                          ),
                        )
                      ),
                    ), 
                    CupertinoButton(
                      onPressed: () {},
                      child: Container(
                        width: 80,
                        height:100,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                        child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(pizzaicon),
                              Text("Pizza",style:GoogleFonts.josefinSans(fontSize:16,color: Colors.black))
                            ],
                          ),
                        )
                      ),
                    ), 
                    CupertinoButton(
                      onPressed: () {},
                      child: Container(
                        width: 80,
                        height:100,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                        child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(desserticon),
                              Text("Dessert",style:GoogleFonts.josefinSans(fontSize:16,color: Colors.black))
                            ],
                          ),
                        )
                      ),
                    ), 
                    CupertinoButton(
                      onPressed: () {},
                      child: Container(
                        width: 80,
                        height:100,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)
                        ),
                        child:Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(drinkicon),
                              Text("Drink",style:GoogleFonts.josefinSans(fontSize:16,color: Colors.black))
                            ],
                          ),
                        )
                      ),
                    ), 
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("Our Menu",style:GoogleFonts.josefinSans(fontSize:22)),
                  const Spacer(),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const Menu()));
                    },
                    child: Text("See all",style:GoogleFonts.poppins(fontSize:18,color:Colors.orange))
                  )
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/Rectangle7.png"),
                        Text("Daylight Coffee",style:GoogleFonts.lato(fontSize:22)),
                      ],
                    ),
                    const SizedBox(width:20),
                    Column(
                      children: [
                        Image.asset("assets/images/Rectangle8.png"),
                        Text("Dark Brownie",style:GoogleFonts.lato(fontSize:22)),
                      ],
                    ),
                  ],
                ),              
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(  
        child: ListView(  
          padding: EdgeInsets.zero,  
          children: <Widget> [  
            UserAccountsDrawerHeader(  
              accountName: Text("${userData?['name'] ?? 'N/A'}",style:GoogleFonts.poppins(fontSize:20)),
              accountEmail: Text("${userData?['email'] ?? 'N/A'}"),  
              currentAccountPicture: const CircleAvatar(  
                backgroundColor: Colors.orange,  
                child: Text(  
                  "M",  
                  style: TextStyle(fontSize: 40.0),  
                ),   
              ),  
            ),  
            ListTile(  
              leading: const Icon(Icons.home), 
              title: Text("Home",style: GoogleFonts.poppins()),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: const Icon(Icons.fastfood_outlined), 
              title: Text("Menu",style: GoogleFonts.poppins()),  
              onTap: () {  
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Menu()));  
              },  
            ),
            ListTile(  
              leading: const Icon(Icons.card_giftcard), 
              title: Text("Cart",style: GoogleFonts.poppins()),  
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Cart()));  
              },  
            ),
            ListTile(  
              leading: const Icon(Icons.favorite), 
              title: Text("Wishlist",style: GoogleFonts.poppins()),  
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Wishlist()));
              },  
            ),
            ListTile(  
              leading: const Icon(Icons.person), 
              title: Text("Proflie",style: GoogleFonts.poppins()),  
              onTap: () {  
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const Proflie()));
              },  
            ),  
          ],  
        ),  
      ),  
    );
  }
}

class AdPage extends StatelessWidget {
  final String image;

  AdPage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}