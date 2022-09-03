import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatelessWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email = '', pass = '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                          .createUserWithEmailAndPassword(
                              email: email, password: pass);
                      Navigator.pushNamed(context, 'home');
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Weak Password'),
                                content: Text('Please Enter Strong Password'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'register');
                                      },
                                      child: Text('OK')),
                                ],
                              );
                            });
                      } else if (e.code == 'email-already-in-use') {
                        showDialog(
                            context: (context),
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Account Already Exist'),
                                content: Text(
                                    'This Email is Already Registerd Try Different Email Or Login With This Email'),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, 'register');
                                      },
                                      child: Text('OK')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, 'login');
                                      },
                                      child: Text('Login'))
                                ],
                              );
                            });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Create')),
            ],
          ),
        ),
      ),
    );
  }
}
