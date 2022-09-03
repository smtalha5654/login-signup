import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '', pass = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(hintText: 'Email'),
              ),
              TextField(
                onChanged: (value) {
                  pass = value;
                },
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                              email: email, password: pass);
                      Navigator.pushNamed(context, 'home');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text('User Not Found'),
                                content: Text('Please Create Account First'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'login');
                                      },
                                      child: Text('OK')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'register');
                                      },
                                      child: Text('Create Account'))
                                ],
                              );
                            });
                      } else if (e.code == 'wrong-password') {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Wrong Password'),
                                content: Text('Please Enter Correct Password'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'login');
                                      },
                                      child: Text('OK')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'login');
                                      },
                                      child: Text('Forget Password'))
                                ],
                              );
                            });
                      }
                    }
                  },
                  child: Text('Submit')),
            ],
          ),
        ),
      ),
    );
  }
}
