import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'Registration.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffcae8ff),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 209.0,right: 20,left: 20),
            child: Card(
              color:  Colors.amber,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    SizedBox(
                      height: 00.0,
                    ),
                    Text(
                      "S.I.M.S",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 10.0,
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Column(children: [
                      SizedBox(
                        height: 45.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: TextField(
                          style: TextStyle(color: Colors.black38),
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black)),
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          controller: passwordTextEditingController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(100.0))
                          ),
                        ),
                      ),

                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: SizedBox(
                      //       height: 20.0,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           Navigator.pushNamed(
                      //             context,
                      //             ForgotPassword.id,
                      //           );
                      //         },
                      //         child: Text(
                      //           'Forgot Password?',
                      //           style: TextStyle(color: Colors.grey, fontSize: 12),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 20.0,
                      ),

                      SizedBox(
                        height: 50,
                        width: 100,
                        //double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                              // side: BorderSide(color: bcolor)
                            ),
                            backgroundColor: Colors.amber,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: Colors.black38,
                                fontFamily: 'Manrope',
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            if (!emailTextEditingController.text
                                .contains("@")) {
                              displayToast(
                                  "Email address is not Valid", context);
                            } else if (passwordTextEditingController
                                .text.isEmpty) {
                              displayToast("Password is mandatory", context);
                            } else {
                              loginAndAuthenticateUser(context);
                            }
                          },
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 5,
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //
                    //     },
                     GestureDetector(
                       onTap: (){

                         Navigator.pushNamedAndRemoveUntil(context, '/registration', (route) => false);
                       },
                       child: Text(
                            'Do You Have An Account? Register',
                            style: TextStyle(color: Colors.black38),
                          ),
                     )
                  ]),
                )),
          ),
        ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          AlertDialog alert = AlertDialog(
            content: new Row(
              children: [
                CircularProgressIndicator(),
                Container(
                    margin: EdgeInsets.only(left: 5), child: Text("Loading")),
              ],
            ),
          );
          return alert;
        });

    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) // user created
    {
      //save use into to database

      userRef.child(firebaseUser.uid).once().then((event) {
        if (event != null) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          displayToast("You are logged-in", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToast(
              "User does not exist,Please create new account.", context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToast("user has not been created", context);
    }
  }
}
