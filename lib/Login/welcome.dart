import 'package:flutter/material.dart';
import 'package:foody/Login/sign_in.dart';
import 'package:foody/Login/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          children: [
            Image.asset("assets/images/welcome.jpg"),
            Image.asset("assets/images/logo.png",width:250),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(320, 60),
                textStyle: const TextStyle(fontSize: 24),
                backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
              ),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()));}, 
              child:  Text("Sign In", style:GoogleFonts.lato(color: Colors.black))
            ),
            const SizedBox(height:20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(320, 60),
                textStyle: const TextStyle(fontSize: 24),
                backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
              ),
              onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));},
              child: Text("Sign Up", style:GoogleFonts.lato(color: Colors.black))
            )
          ]
        )
      )
    );
  }
}