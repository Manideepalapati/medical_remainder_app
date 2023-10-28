import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Contact{
  String? _id;
  String? _MedicineName;
  int? _hour;
  int? _minute;


 String? get id => this._id;


  get MedicineName => this._MedicineName;

 set MedicineName( value) => this._MedicineName = value;

 

  get hour => this._hour;

 set hour( value) => this._hour = value;

  get minute => this._minute;

 set  minute( value) => this._minute = value;

  

  

  Contact(this._MedicineName,this._hour,this._minute);

  Contact.withId(this._id,this._MedicineName,this._hour,this._minute);
  
  Contact.fromSnapshot(DataSnapshot snapshot){
    var value = Map<String, dynamic>.from(snapshot.value as Map);
    this._id=snapshot.key;
    this._MedicineName=value['MedicineName'];
    this._hour=value['hour'];
    this._minute=value['minute'];
    
  }

  Map<String,dynamic> toJson(){
    return {
      "MedicineName":_MedicineName,
      "hour":_hour,
      "minute":_minute,
      

    };
  }

}