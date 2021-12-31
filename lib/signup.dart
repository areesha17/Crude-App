import 'package:firebase/home.dart';
import 'package:firebase/login.dart';
import 'package:firebase/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({ Key? key }) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
 TextEditingController emailController=  TextEditingController();
 TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future Signup() async{
  try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  }
} catch (e) {
  print(e);
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("SignUp", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 60,
          ),
          const TextField(
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                filled: true,
              ),
            ),
          const SizedBox(height: 30.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Phone or Email",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 30.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                filled: true,
              ),
            ),
            const SizedBox(
              height: 15,
              width: 25,
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 40,
                  buttonColor: Colors.blue.shade800,
                  child: ElevatedButton(
                    onPressed: () {
                      Signup();
                      CircularProgressIndicator();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text('SignUp',
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
              width: 20,
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  buttonColor: Colors.green,
                  height: 20,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Already have an account',
                        style: TextStyle(fontSize: 18, color: Colors.black)),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
    