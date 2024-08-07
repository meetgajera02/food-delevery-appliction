import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/Login/sign_in.dart';
import 'package:foody/Screen/Login/sign_up.dart';
import 'package:foody/constants/constants.dart';
import 'package:foody/constants/image.dart';
import 'package:google_fonts/google_fonts.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {

  TextEditingController email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(forget),
            Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    controller: email,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(),
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Back To",style: GoogleFonts.poppins()),
                      TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()));},
                        child: Text("Sign in",style: GoogleFonts.poppins(color: const Color.fromRGBO(225, 185, 17, 1)),)
                      ),
                    ]
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 60), 
                      backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
                      textStyle: const TextStyle(fontSize: 24)
                    ),
                    onPressed: (){
                      
                      _auth.sendPasswordResetEmail(email: email.text.toString()).then((value){
                        showMessage("email are send");
                      }).onError((error, stackTrace) {
                        showMessage(error.toString());
                      });
                    },
                    child: Text("Send",style: GoogleFonts.poppins(color: Colors.black))
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t Have An Account?",style: GoogleFonts.poppins()),
                      TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));},
                        child: Text("Sign Up",style: GoogleFonts.poppins(color: const Color.fromRGBO(225, 185, 17, 1)),)
                      )
                    ],
                  )
                ],
              )
            ),
          ),
          ],
        ),
      ),
    );
  }
}