import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Myregister extends StatefulWidget {
  const Myregister({Key? key}) : super(key: key);

  @override
  State<Myregister> createState() => _MyregisterState();
}

class _MyregisterState extends State<Myregister> {
  @override
  Widget build(BuildContext context) {
    String email = '';
    String pass = '';
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/register.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 45, top: 100),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4,
                        left: 35,
                        right: 35),
                    child: Column(
                      children: [
                        TextField(
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        SizedBox(
                          height: 20,
                        ),
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
                        padding: EdgeInsets.only(top: 513, left: 140),
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
                                        .createUserWithEmailAndPassword(
                                            email: email, password: pass);
                                Navigator.pushNamed(context, 'login');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  AlertDialog(
                                    title: Text('Password is Weak'),
                                    content:
                                        Text('Try Longer And Harder Password'),
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
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  AlertDialog(
                                    title: Text(
                                        'The account already exists for that email.'),
                                    content:
                                        Text('Try Different Email Address'),
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
                                      'The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.forward,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Create",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
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
                      height: 40,
                      width: 100,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 26, 26, 26)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, 'login');
                        },
                        child: Text(
                          "Login",
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
