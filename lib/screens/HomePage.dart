import 'package:flutter/material.dart';
import 'addContact.dart';
import 'editContact.dart';
import 'viewContact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference _databaseReference=FirebaseDatabase.instance.ref();

  navigateToAddScreen(){
    Navigator.push(context, MaterialPageRoute(builder: 
    (context){
      return AddContact();
    }));
  }
  navigateToEditScreen(id){
    Navigator.push(context, MaterialPageRoute(builder: 
    (context){
      return EditContact(id);
    }));
  }
  navigateToViewScreen(id){
    Navigator.push(context, MaterialPageRoute(builder: 
    (context){
      return ViewScreen(id);
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SMART MEDICAL BOX"),
      ),
      body: Container(
        child: FirebaseAnimatedList(
          query: _databaseReference, 
          itemBuilder:(BuildContext context, DataSnapshot snapshot,Animation<double> animation,int index) {
            var value = Map<String, dynamic>.from(snapshot.value as Map);
            return GestureDetector(
              onTap: (){
                navigateToViewScreen(snapshot.key);
              },
              child: Card(
                color: Colors.white,
                elevation: 2.0,
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/logo.png") as ImageProvider
                        
                        ),
                      ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${value['MedicineName']}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${value['hour']} : ${value['minute']}"
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
          ),
      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: navigateToAddScreen,
      //   child: Icon(Icons.add),
        
      //   ),
    );
  }
}