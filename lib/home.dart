

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/storage.dart/screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController taskcontroller = TextEditingController();
  addData() async{
    await FirebaseFirestore.instance.collection('task').add({
      'name': taskcontroller.text,
      'date': '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}'
    });
    taskcontroller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Card(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: taskcontroller,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        addData();
                      }, 
                      child: Text("ADD"),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Screen()));
                      },
                      child: Text("If you want to Upload File"),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('task').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (snapshot.hasError){
                  return Text("Something went Wrong");
                } 
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return  ListView(
                    children: 
                      snapshot.data!.docs.map((DocumentSnapshot document){
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['date']),
                        trailing: Wrap(
                          spacing: 1,
                          children: [
                            IconButton(
                              onPressed: (){document.reference.delete();}, 
                              icon: Icon(Icons.delete)),
                              IconButton(
                                onPressed: (){showDialog(context: context, builder: (context){
                                  return AlertDialog(
                                    title: Text("Update task"),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: taskEditController,
                                        ),
                                        ElevatedButton(
                                          onPressed: (){document.reference.update({'name': taskEditController.text});
                                          Navigator.pop(context);
                                          taskEditController.clear();},
                                          child: Text("Update"),
                                        ),
                                      ],
                                    ),
                                  );
                                });}, 
                                icon: Icon(Icons.update)),
                          ],
                        ),
                      );
                      }).toList(),
                    
                  );
              }
              ),
            ),
          ],
        ),
      ),  
    );
  }
    TextEditingController taskEditController = TextEditingController();
}