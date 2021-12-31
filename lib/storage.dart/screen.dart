import 'package:firebase/storage.dart/storage_helper.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';


class Screen extends StatefulWidget {
  const Screen({ Key? key }) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
   var results;
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: ()async{
            results = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ["pdf", "jpg", "png", "jpeg"],
            );
            setState(() {
              results = results;
            });
            print(results.files.single.path);
            if (results == null){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Files chosen"),),);
            }
            final pathname = results.files.single.path;
            final filename = results.files.single.name;
            storage.uploadFile(pathname, filename);
          }, 
          child: Text("Upload File Here")),
        if (results != null)
          Container(
            child: Image.file(File(results.files.single.path)),
          ),
        
      ],
    ),
    );
  }
}