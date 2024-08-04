import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody/Screen/Address/add_address.dart';
import 'package:foody/Model/address_model.dart';
import 'package:foody/Screen/profile/payment.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAddress extends StatelessWidget {
  const ViewAddress({super.key,});

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    // ignore: non_constant_identifier_names
    Future<List<AddressModel>> ViewAddress() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser!.uid)
            .collection('address')
            .get();
    return querySnapshot.docs.map((e) => AddressModel.fromJson(e.data())).toList();
  }

    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);}  , 
          icon: const Icon(Icons.arrow_back_ios,)
        ),
        title: Text("Address",style:GoogleFonts.poppins(fontSize:22,color:const Color.fromARGB(255, 178, 125, 0)))
      ),
      body: FutureBuilder<List<AddressModel>>(
        future: ViewAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Address found'));
          }

          // ignore: non_constant_identifier_names
          List<AddressModel> Address = snapshot.data!;
          return ListView.builder(
            itemCount: Address.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: CupertinoButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Payment()));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [BoxShadow(color: Color.fromARGB(255, 243, 243, 243))],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Address[index].name,style:GoogleFonts.poppins(fontSize:18,fontWeight: FontWeight.w600,color: Colors.black)),
                              Text(Address[index].building,style:GoogleFonts.poppins(fontSize:16,color: Colors.black)),
                              Text(Address[index].area,style:GoogleFonts.poppins(fontSize:16,color: Colors.black)),
                              Title(
                                color: Colors.black,
                                child: Text("${Address[index].city}, ${Address[index].state} - ${Address[index].pinCode}",style:GoogleFonts.poppins(fontSize:16,color: Colors.black)),
                              ),
                              const SizedBox(height: 1),
                              Text(Address[index].phone,style:GoogleFonts.poppins(fontSize:16,color: Colors.black))
                            ]
                          ),
                          const Spacer(),
                          CupertinoButton(
                            onPressed: () {},
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.amber
                                )
                              ),
                              child: Text("Change",style: GoogleFonts.poppins(fontSize:16,color: Colors.amber)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        label: const Text('Add New Address',style: TextStyle(color: Color.fromARGB(255, 178, 125, 0))),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddress(),
            ),
          );
        },
        icon: const Icon(Icons.add, color: Color.fromARGB(255, 178, 125, 0), size: 25),
      ),
    );
  }
}

