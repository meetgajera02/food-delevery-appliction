import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/Login/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Proflie extends StatefulWidget {
  const Proflie({super.key});

  @override
  State<Proflie> createState() => _ProflieState();
}

class _ProflieState extends State<Proflie> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context, false), 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title:  Text("Profile",style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal:20,vertical:10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  // appProvider.getUserInformation.image == null
                  //   ? const Icon(
                  //       Icons.person_outline,
                  //       size: 120,
                  //     )
                  //   : CircleAvatar(
                  //       backgroundImage:
                  //           NetworkImage(appProvider.getUserInformation.image!),
                  //       radius: 60,
                  //     ),.
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset('assets/images/meet.JPG',width: 96,height: 96)
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Meet",style:GoogleFonts.poppins(fontSize:22)),
                      Text("+91 9537230057",style:GoogleFonts.poppins(fontSize:18,color:const Color.fromARGB(125, 87, 87, 85))),
                      TextButton(
                        onPressed: () {},
                        child:Text("View Profile",style:GoogleFonts.poppins(fontSize:18,color:const Color.fromARGB(255, 178, 125, 0))), 
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal:30,vertical:10),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.clock,color:  Color.fromARGB(255, 178, 125, 0)),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Store Delivery Info",style:GoogleFonts.poppins(fontSize:16,color:const Color.fromARGB(255, 178, 125, 0))),
                      Text("Approx Delivery Time is: 30 mins",style:GoogleFonts.poppins(fontSize:12,color:const Color.fromARGB(125, 87, 87, 85))),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Column(
                children: [
                  Prifilemenu(title: 'Share this app',icon: Icons.share,onPressed: (){Share.share('com.example.foody');}),
                  Prifilemenu(title: 'Rate Us',icon: Icons.star_border,onPressed: (){}),
                  Prifilemenu(
                    title: 'Your Order',
                    icon: Icons.shopping_cart,
                    onPressed: (){}
                  ),
                  Prifilemenu(
                    title: 'Change Password',
                    icon: Icons.change_circle_outlined,
                    onPressed: (){}
                  ),
                  const Divider(),
                  Prifilemenu(
                    title: 'Logout',
                    icon: Icons.logout,
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const SignIn()));
                      });
                    },
                    TextColor:  const Color.fromARGB(255, 178, 125, 0),
                    endIcon: false
                  ),   
                ],
              ),             
            ),
          ],
        ),
      ),
    );
  }
}

class Prifilemenu extends StatelessWidget {
  const Prifilemenu({super.key,
  required this.title,
  required this.icon,
  required this.onPressed,
  this.endIcon = true,
  // ignore: non_constant_identifier_names
  this.TextColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  final bool endIcon;
  // ignore: non_constant_identifier_names
  final Color? TextColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: Colors.grey
          ),
        ),
        child: Icon(icon),
      ),
      title: Text(title,style:GoogleFonts.poppins(fontSize:18,color: Colors.black).apply(color: TextColor)),
      trailing: endIcon? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.grey.withOpacity(0.1)
        ),
        child: const Icon(FontAwesomeIcons.angleRight, color: Colors.grey,size: 18.0)):null
    );
  }
}