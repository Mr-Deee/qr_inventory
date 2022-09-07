import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";

  User? currentfirebaseUser;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  String ?_email, _password, _name,_lastname, _mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200.0,
              ),
              Text(
                "S.I.M.S",
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w700,
                    color: Colors.amber),
                textAlign: TextAlign.center,
              ),
              Text(
                "",
                style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: "Brand Bold",
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.amber)),
                      child: TextField(
                        onChanged: (value) {
                          _name= value;
                        },
                        style: TextStyle(color: Colors.black),
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            //      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.amber)),
                      child: TextField(
                        style: TextStyle(color: Colors.black),

                          onChanged: (value) {
                            _email= value;
                          },
                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            //enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.amber)),
                      child: TextField(
                        onChanged: (value) {
                          _mobileNumber= value;
                        },
                        style: TextStyle(color: Colors.black),
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Phone",
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.amber)),
                      child: TextField(
                        onChanged: (value) {
                          _password= value;
                        },
                        style: TextStyle(color: Colors.black),
                        controller: passwordTextEditingController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Colors.amber,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    color: Colors.amber,
                    textColor: Colors.black38,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand Bold"),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    onPressed: () {
                      if (nameTextEditingController.text.length < 3) {
                        displayToast(
                            "Name must be atleast 3 characters.", context);
                      } else if (!emailTextEditingController.text
                          .contains("@")) {
                        displayToast("Email address is not Valid", context);
                      } else if (phoneTextEditingController.text.isEmpty) {
                        displayToast("Phone Number is mandatory", context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToast(
                            "Password must be atleast 6 Characters", context);
                      } else {
                        registerNewUser(context);
                        registerInfirestore(context);
                      }
                    },
                  ),
                ]),
              ),
              FlatButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                child: Text("Do You Already Have An Account? Login",
                style: TextStyle(
                  color: Colors.black38
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          AlertDialog alert = AlertDialog(
            content: new Row(
              children: [
                CircularProgressIndicator(),
                Container(
                    margin: EdgeInsets.only(left: 5), child: Text("Registering..Please wait")),
              ],
            ),
          );
          return alert;

          //ProgressDialog(message: "Registering,Please wait.....",);
        });
    registerInfirestore(context);

    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
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

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;

      displayToast("Congratulation, your account has been created", context);

      Navigator.pushNamed(context, '/home');
    } else {
      Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }

  Future<void> registerInfirestore(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null) {
      FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
        'Name': _name,
        //'lastName': _lastname,
        'MobileNumber': _mobileNumber,
       'Password':_password,
        'Email': _email,
        // 'Gender': Gender,
        // 'Date Of Birth': birthDate,
      });
    }
    print("Registered");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) {
    //     return SignInScreen();
    //   }),
    // );


  }
}

displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
