

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../modals/Contact.dart';

class EditContact extends StatefulWidget {
  final String id;
  EditContact(this.id);

  @override
  State<EditContact> createState() => _EditContactState(id);
}

class _EditContactState extends State<EditContact> {
  String id;
  _EditContactState(this.id);
  String _MedicineName="";
  String _hour="";
  String _minute="";

  TextEditingController _fnController=TextEditingController();
  TextEditingController _lnController=TextEditingController();
  TextEditingController _poController=TextEditingController();
  

  bool isLoading=true;
  DatabaseReference _databaseReference=FirebaseDatabase.instance.ref();

  @override
  void initState(){
    super.initState();
    this.getContact(id);
  }
  getContact(id) async {
    Contact contact;
    _databaseReference.child(id).onValue.listen((event) {
      contact=Contact.fromSnapshot(event.snapshot);
      _fnController.text=contact.MedicineName;
      _lnController.text=contact.hour.toString();
      _poController.text=contact.minute.toString();
      

      setState(() {
        _MedicineName=contact.MedicineName;
        _hour=contact.hour.toString();
        _minute=contact.minute.toString();
        

        isLoading=false;
      });

    }); }

    updateContact(BuildContext context) async {
      if(_MedicineName.isNotEmpty &&
          _hour.isNotEmpty &&
          _minute.isNotEmpty 
          ){
            Contact contact=Contact.withId(id, _MedicineName,int.parse(_hour),int.parse(_minute));
            await _databaseReference.child(id).set(contact.toJson());
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

   

  NavigateToLastScreen(BuildContext context){
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact"),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: <Widget>[
                    //image view
                    Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          // onTap: () {
                          //   this.PickImage();
                          // },
                          child: Center(
                            child: Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image:AssetImage("images/placeholder.png") as ImageProvider
                                    ))),
                          ),
                        )),
                    //
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _MedicineName = value;
                          });
                        },
                        controller: _fnController,
                        decoration: InputDecoration(
                          labelText: 'Medicine Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //hour
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _hour = value;
                          });
                        },
                        controller: _lnController,
                        decoration: InputDecoration(
                          labelText: 'hour',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    //minute
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            _minute = value;
                          });
                        },
                        controller: _poController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'minute',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    
                    // update button
                    Container(
                      padding: EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 20.0),
                          backgroundColor: Colors.red,
                        ),
                        
                        onPressed: () {
                          updateContact(context);
                        },
                        
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }

}

  