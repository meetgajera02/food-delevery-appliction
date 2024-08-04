import 'package:flutter/material.dart';
import 'package:foody/constants/constants.dart';
import 'package:foody/constants/image.dart';
import 'package:foody/firebase_services/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isShowPassword = true;
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          "New Password",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 50,
            ),
            Center(
              child:SizedBox(
                width: 150,
                height: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(logo),
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextFormField(
              controller: newpassword,
              obscureText: isShowPassword,
              style: GoogleFonts.poppins(),
              decoration: InputDecoration(
                hintText: "New Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                prefixIcon: const Icon(
                  Icons.key,
                ),
                suffixIcon: IconButton(
                  icon : isShowPassword? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      isShowPassword = !isShowPassword;
                    });
                  },
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            TextFormField(
              controller: confirmpassword,
              obscureText: isShowPassword,
              style: GoogleFonts.poppins(),
              decoration:  InputDecoration(
                hintText: "Confrim Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                prefixIcon: const Icon(
                  Icons.key,
                ),
              ),
            ),
            const SizedBox(
              height: 36.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(280, 60),
                textStyle: const TextStyle(fontSize: 24),
                backgroundColor: const Color.fromRGBO(255, 204, 0, 1)
              ),
              onPressed: () async{
                if (newpassword.text.isEmpty) {
                  showMessage("New Password is empty");
                } else if (confirmpassword.text.isEmpty) {
                  showMessage("Confirm Password is empty");
                } else if (confirmpassword.text == newpassword.text) {
                  FirebaseAuthHelper.instance
                      .changePassword(newpassword.text, context);
                } else {
                  showMessage("Confrim Password is not match");
                }
              }, 
              child: Text("Save",style: GoogleFonts.poppins(color: Colors.black))
            ),
          ],
        ),
      ),
    );
  }
}
