import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'editContact.dart';
import '../modals/Contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewScreen extends StatefulWidget {
  final String id;
  ViewScreen(this.id);

  @override
  State<ViewScreen> createState() => _ViewScreenState(id);
}

class _ViewScreenState extends State<ViewScreen> {
  DatabaseReference _databaseReference=FirebaseDatabase.instance.ref();
  String id;
  _ViewScreenState(this.id);
  Contact? _contact;
  bool isLoading=true;
  getContact(id) async {
    _databaseReference.child(id).onValue.listen((event) {
      setState(() {
        _contact=Contact.fromSnapshot(event.snapshot);
        isLoading=false;
      });
    });
  }
  @override
  void initState(){
    super.initState();
    this.getContact(id);
  }

  // callAction(String number) async {
  //   String url='tel:$number';
  //   if(await canLaunchUrlString(url)){
  //     await launchUrlString(url);
  //   }else{
  //     throw 'could not send call to $number';
  //   }
  // }
  // smsAction(String number) async {
  //   String url='tel:$number';
  //   if(await canLaunchUrlString(url)){
  //     await launchUrlString(url);
  //   }else{
  //     throw 'could not send send to $number';
  //   }
  // }
  deleteContact(){
    showDialog(
      context: context,
       builder: (context) {
         return AlertDialog(
          title: Text("Delete?"),
          content: Text("Delete Contact?"),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("cancel")),
            TextButton(onPressed: () async {
              Navigator.of(context).pop();
              await _databaseReference.child(id).remove();
              NavigateToLastScreen();
            }, child: Text("Delete")),
          ],
         );
       });

  }

  NavigateToLastScreen(){
    Navigator.pop(context);
  }

  NavigateToEditScreen(id){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return EditContact(id);
    }));
  }


 @override
  Widget build(BuildContext context) {
    // wrap screen in WillPopScreen widget
    return Scaffold(
      appBar: AppBar(
        title: Text("View Contact"),
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  // header text container
                  Container(
                      height: 200.0,
                      child: Image(
                        //
                        image: AssetImage("assets/logo.jpg") as ImageProvider,
                        fit: BoxFit.contain,
                      )),
                  //name
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.perm_identity),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              "${_contact!.MedicineName} ",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // phone
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.phone),
                            Container(
                              width: 10.0,
                            ),
                            Text(
                              "Time: ${_contact!.hour} : ${_contact!.minute}",
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        )),
                  ),
                  // email
                  
                  // edit and delete
                  Card(
                    elevation: 2.0,
                    child: Container(
                        margin: EdgeInsets.all(20.0),
                        width: double.maxFinite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.edit),
                              color: Colors.red,
                              onPressed: () {
                                NavigateToEditScreen(id);
                              },
                            ),
                            IconButton(
                              iconSize: 30.0,
                              icon: Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () {
                                deleteContact();
                              },
                            )
                          ],
                        )),
                  )
                ],
              ),
      ),
    );
  }

}