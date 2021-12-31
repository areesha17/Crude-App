import 'package:firebase/SignUp.dart';
import 'package:firebase/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   FirebaseAuth auth = FirebaseAuth.instance;
   Future Login() async{
     try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text,
    password: passwordController.text
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    print('No user found for that email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password provided for that user.');
  }
}
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Login", style: TextStyle(fontSize: 20, color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          const SizedBox(height: 60.0),
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
            const SizedBox(height: 20.0),
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
              height: 20,
              width: 25,
            ),
            Column(
              children: <Widget>[
                ButtonTheme(
                  height: 40,
                  buttonColor: Colors.blue.shade800,
                  child: ElevatedButton(
                    onPressed: () {
                      Login();
                      CircularProgressIndicator();
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home()));                    },
                    child: Text('Log In',
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Signup()));
                    },
                    child: Text('Create New Account',
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