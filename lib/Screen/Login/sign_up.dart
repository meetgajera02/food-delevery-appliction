import 'package:flutter/material.dart';
import 'package:foody/Screen/Login/sign_in.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/constants/constants.dart';
import 'package:foody/constants/image.dart';
import 'package:foody/firebase_services/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(signup),
            Center(
              child: Container(
              padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: name,
                      style: GoogleFonts.poppins(),
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.poppins(),
                        labelText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
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
                  TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(),
                      labelText: "Phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: password,
                    obscureText: isShowPassword,
                    style: GoogleFonts.poppins(),
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(),
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      suffixIcon: IconButton(
                        icon : isShowPassword? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            isShowPassword = !isShowPassword;
                          });
                        },
                        padding: EdgeInsets.zero,
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 60),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
                    ),
                    onPressed: () async {
                      bool isVaildated = signUpVaildation(email.text, password.text,name.text,phone.text);
                      if (isVaildated) {
                        bool isLogined = await FirebaseAuthHelper.instance
                            .signUp(name.text,email.text, password.text,phone.text, context);
                        // ignore: use_build_context_synchronously
                        if (isLogined) {Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));}
                      }
                    },
                    child: Text("Sign Up",style: GoogleFonts.poppins(color: Colors.black))
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already Have An Account?",style: GoogleFonts.poppins()),
                      TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignIn()));},
                        child: Text("Sign In",style: GoogleFonts.poppins(color: const Color.fromRGBO(225, 185, 17, 1)),)
                      )
                    ],
                  )
                ],
              )
            ),
          ),
        ]
        ),
      ),
    );
  }
}