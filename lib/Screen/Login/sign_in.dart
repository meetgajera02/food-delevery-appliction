import 'package:flutter/material.dart';
import 'package:foody/Screen/Login/forget_password.dart';
import 'package:foody/Screen/Login/sign_up.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/constants/constants.dart';
import 'package:foody/constants/image.dart';
import 'package:foody/firebase_services/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isShowPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:[
            Image.asset(signin),
           Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const Forget()));},
                        child: Text("Forget Password?",style:GoogleFonts.poppins())
                      ),
                    ]
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(280, 60),
                      textStyle: const TextStyle(fontSize: 24),
                      backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
                    ),
                    onPressed: () async{
                      bool isVaildated = loginVaildation(email.text, password.text);
                      if (isVaildated) {
                        bool isLogined = await FirebaseAuthHelper.instance
                          .login(email.text, password.text, context);
                        // ignore: use_build_context_synchronously
                        if (isLogined) {Navigator.push(context, MaterialPageRoute(builder: (context)=> const Home()));}
                      }
                    },
                    child: Text("Sign In",style:GoogleFonts.poppins(color: Colors.black))
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t Have An Account?",style:GoogleFonts.poppins()),
                      TextButton(
                        onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));},
                        child:  Text("Sign Up",style:GoogleFonts.poppins(color: const Color.fromRGBO(225, 185, 17, 1)),)
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