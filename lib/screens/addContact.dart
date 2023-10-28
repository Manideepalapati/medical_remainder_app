import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:io';
import '../modals/Contact.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

  DatabaseReference _databaseReference=FirebaseDatabase.instance.ref();

  String _MedicineName="";
  String _hour="";
  String _minute="";
  int count=0;
  

  var list=["M1","M2","M3","M4"];

  
  // bool check(){
  //   bool result=false;
  //   _databaseReference.child(list[count]).onValue.listen((event) {
  //       Contact contact =Contact.fromSnapshot(event.snapshot);
  //       if((contact.MedicineName).isNotEmpty){
  //         result=true;
  //       }
  //       return result;
  //     });
  // }
  saveContact(BuildContext context) async {
    if(_MedicineName.isNotEmpty &&
     _hour.isNotEmpty &&
     _minute.isNotEmpty ){
      Contact contact=Contact(this._MedicineName,int.parse(_hour),int.parse(_minute));
      
      
      
      await _databaseReference.child(list[3]).set(contact.toJson());
      
      print(count);
      
      NavigateToLastScreen(context);
     }
     else{
      showDialog(
        context: context,
         builder: (context){
          return AlertDialog(
            title: Text("Alert"),
            content: Text("All fields are required"),
            actions: [
              TextButton(onPressed:(){ Navigator.of(context).pop();},
               child: Text("close"))
            ],
          );
         }
         );

     }
     
  }

 
  


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Contact"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top:20),
                child: GestureDetector(
                  // onTap: () {
                  //   this.PickImage();
                  // },
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  AssetImage("assets/logo.jpg") as ImageProvider
                        )
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _MedicineName=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Medicine Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),

              ),
              //last name
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //   child: TextField(
              //     onChanged: (value){
              //       setState(() {
              //         _lastName=value;
              //       });
              //     },
              //     decoration: InputDecoration(
              //       labelText: "Last Name",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       )
              //     ),
              //   ),

              // ),
              //hour
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _hour=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "hour",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),

              ),
              //minute
              Container(
                margin: EdgeInsets.only(top: 20),
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _minute=value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "minute",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                  ),
                ),

              ),
              //address
              // Container(
              //   margin: EdgeInsets.only(top: 20),
              //   child: TextField(
              //     onChanged: (value){
              //       setState(() {
              //         _address=value;
              //       });
              //     },
              //     decoration: InputDecoration(
              //       labelText: "Address",
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       )
              //     ),
              //   ),

              // ),
              Container(
                child: ElevatedButton(
                  onPressed: (() {
                    saveContact(context);
                  }),
                   child:Text(
                    "Save",style: TextStyle(fontSize: 12,color: Colors.white),
                    )
                    ,
              ))
            ],
          ),
          ),
      ),
    );
  }
  
   NavigateToLastScreen(BuildContext context) {
    Navigator.of(context).pop();
   }
}