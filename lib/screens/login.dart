import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_page/screens/register.dart';

class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  @override
  Widget build(BuildContext context) {
    String email = '';
    String pass = '';
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 45, top: 100),
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.5,
                        left: 35,
                        right: 35),
                    child: Column(
                      children: [
                        TextField(
                            onChanged: (value) {
                              email = value;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                            onChanged: (value) {
                              pass = value;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 500, left: 140),
                        child: SizedBox(
                          height: 45,
                          width: 140,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 26, 26, 26))),
                            onPressed: () async {
                              try {
                                UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: email, password: pass);
                                Navigator.pushNamed(context, 'home');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  AlertDialog(
                                    title: Text('User Not Found'),
                                    content: Text(
                                        'Please Register You Account First'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, 'login');
                                        },
                                        child: Text('Ok'),
                                      )
                                    ],
                                  );
                                } else if (e.code == 'wrong-password') {
                                  AlertDialog(
                                    title: Text('Wrong Password'),
                                    content:
                                        Text('Please Enter Correct Password'),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'register');
                                        },
                                        child: Text('Ok'),
                                      )
                                    ],
                                  );
                                  print(
                                      'Wrong password provided for that user.');
                                }
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.forward,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Login",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  mainAxisAlignment: (MainAxisAlignment.spaceEvenly),
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                      top: 1220,
                    )),
                    SizedBox(
                      height: 60,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 26, 26, 26)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 60),
                      child: SizedBox(
                        child: TextButton(
                            onPressed: null,
                            child: Text("Forget Password?",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0)))),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
