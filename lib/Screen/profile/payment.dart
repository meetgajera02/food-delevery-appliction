import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/constants/image.dart';
import 'package:google_fonts/google_fonts.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
          "Payment",
          style: GoogleFonts.poppins(
            fontSize: 22,
            color: const Color.fromARGB(255, 178, 125, 0),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Text("Payment Method",style:GoogleFonts.dmSans(fontSize:25,fontWeight: FontWeight.bold))
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("UPI",style:GoogleFonts.dmSans(fontSize:25,fontWeight: FontWeight.bold)),
                  Container(
                    margin:  const EdgeInsets.fromLTRB(0, 0, 0, 11),
                    width:  double.infinity,
                    height:  1,
                    decoration:  const BoxDecoration (
                      color:  Color(0x7f000000),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CupertinoButton(
                          onPressed: (){},
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(googlepay,width:40)
                                ],
                              ),
                            )
                          ),
                        ),
                        CupertinoButton(
                          onPressed: (){},
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(phonepay,width: 40,)
                                ],
                              ),
                            )
                          ),
                        ),
                        CupertinoButton(
                          onPressed: (){},
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(paytm)
                                ],
                              ),
                            )
                          ),
                        ),
                        
                        CupertinoButton(
                          onPressed: (){},
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(amazonpay)
                                ],
                              ),
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Debit Card",style:GoogleFonts.dmSans(fontSize:25,fontWeight: FontWeight.bold)),
                  Container(
                    margin:  const EdgeInsets.fromLTRB(0, 0, 0, 11),
                    width:  double.infinity,
                    height:  1,
                    decoration:  const BoxDecoration (
                      color:  Color(0x7f000000),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CupertinoButton(
                          onPressed: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Debit()));
                          },
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,size: 30,color: Colors.black,)
                                  //Image.asset("assets/images/google_pay.jpg",width:40)
                                ],
                              ),
                            )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add new debit card",style:GoogleFonts.dmSans(fontSize:22)),
                            Text("Save and pay via cards",style:GoogleFonts.dmSans(fontSize:14)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black,
                  style: BorderStyle.solid
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cradit Card",style:GoogleFonts.dmSans(fontSize:25,fontWeight: FontWeight.bold)),
                  Container(
                    margin:  const EdgeInsets.fromLTRB(0, 0, 0, 11),
                    width:  double.infinity,
                    height:  1,
                    decoration:  const BoxDecoration (
                      color:  Color(0x7f000000),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CupertinoButton(
                          onPressed: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> const Credit()));
                          },
                          child: Container(
                            width: 50,
                            height:50,
                            decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              border: Border.all(color: Colors.black)
                            ),
                            child:const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add,size: 30,color: Colors.black,)
                                  //Image.asset("assets/images/google_pay.jpg",width:40)
                                ],
                              ),
                            )
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Add new cradit card",style:GoogleFonts.dmSans(fontSize:22)),
                            Text("Save and pay via cards",style:GoogleFonts.dmSans(fontSize:14)),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}