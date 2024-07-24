import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                height:50,
              ),
              Row(
                children: [
                  Image.asset("assets/images/logo.png",width: 48,height: 48),
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
                          child: Image.asset('assets/images/meet.JPG',width: 48,height: 48)
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
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Food,drinks or brownie...",
                )
              ),
              const SizedBox(height: 20),
              Image.asset('assets/images/Rectangle.png'),
              const SizedBox(height:20),
            ],
          ),
        ),
      ),
      drawer: Drawer(  
        child: ListView(  
          // Important: Remove any padding from the ListView.  
          padding: EdgeInsets.zero,  
          children: <Widget>[  
            UserAccountsDrawerHeader(  
              accountName: Text("Abhishek Mishra"),  
              accountEmail: Text("abhishekm977@gmail.com"),  
              currentAccountPicture: CircleAvatar(  
                backgroundColor: Colors.orange,  
                child: Text(  
                  "A",  
                  style: TextStyle(fontSize: 40.0),  
                ),   
              ),  
            ),  
            ListTile(  
              leading: Icon(Icons.home), title: Text("Home"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.settings), title: Text("Settings"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
            ListTile(  
              leading: Icon(Icons.contacts), title: Text("Contact Us"),  
              onTap: () {  
                Navigator.pop(context);  
              },  
            ),  
          ],  
        ),  
      ),  
    );
  }
}