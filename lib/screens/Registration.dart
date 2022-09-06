
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


class RegistrationScreen extends StatelessWidget
{
  static const String idScreen="register";

  TextEditingController nameTextEditingController= TextEditingController();
  TextEditingController emailTextEditingController= TextEditingController();
  TextEditingController phoneTextEditingController= TextEditingController();
  TextEditingController passwordTextEditingController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(

            children: [

              SizedBox(height: 90.0,),
              Text(
                "rev",

                style: TextStyle(
                    fontSize: 100.0,
                    fontFamily: "Gilroy",
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),

              Text(
                "Register as a Driver",
                style: TextStyle(fontSize: 10.0, fontFamily: "Brand Bold",color: Colors.black),
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                    children: [

                      SizedBox(height: 1.0,),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: nameTextEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(

                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(

                              color: Colors.black,
                              fontSize: 10.0,
                            )
                        ),
                      ),

                      SizedBox(height: 1.0,),
                      TextField(
                        style: TextStyle(color: Colors.black),

                        controller: emailTextEditingController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Email",
                            labelStyle: TextStyle(

                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )
                        ),
                      ),


                      SizedBox(height: 1.0,),
                      TextField(
                        style: TextStyle(color: Colors. black),
                        controller: phoneTextEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(

                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Phone",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            )
                        ),
                      ),






                      SizedBox(height: 1.0,),
                      TextField(
                        style: TextStyle(color: Colors.black),
                        controller: passwordTextEditingController ,
                        obscureText: true,
                        decoration: InputDecoration(

                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                            labelText: "Password",
                            labelStyle: TextStyle(

                              color: Colors.black87,
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            )
                        ),
                      ),

                      SizedBox(height: 10.0,),
                      RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 18.0, fontFamily: "Brand Bold"),

                            ),

                          ),
                        ),
                        shape:  new RoundedRectangleBorder(
                          borderRadius:  new BorderRadius.circular(24.0),
                        ),
                        onPressed: ()
                        {
                          if(nameTextEditingController.text.length < 3)
                          {
                            displayToast("Name must be atleast 3 characters.", context);

                          }
                          else if(!emailTextEditingController.text.contains("@"))
                          {
                            displayToast("Email address is not Valid", context);
                          }
                          else if(phoneTextEditingController.text.isEmpty)
                          {
                            displayToast("Phone Number is mandatory", context);
                          }

                          else if(passwordTextEditingController.text.length < 6)
                          {
                            displayToast("Password must be atleast 6 Characters", context);
                          }
                          else{
                            registerNewUser(context);
                          }


                        },

                      ),

                    ]
                ),
              ),
              FlatButton(
                textColor: Colors.black,
                onPressed: ()
                {
                  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                },
                child: Text(

                    "Do You Already Have An Account? Login"
                ),
              ),



            ],
          ),
        ),
      ),



    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
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
              ],),
          );
          return alert;

          //ProgressDialog(message: "Registering,Please wait.....",);


        });


    final User?  firebaseUser=(await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToast("Error"+errMsg.toString(), context);

    })).user;

    if (firebaseUser != null)// user created

        {
      //save use into to database


      Map userDataMap={
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),

      };
      driversRef.child(firebaseUser.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;





      displayToast("Congratulation, your account has been created", context);

      Navigator.pushNamed(context, 'UserInfoScreen');

    }
    else
    {
      Navigator.pop(context);
      //error occured - display error
      displayToast("user has not been created", context);
    }
  }

}
displayToast(String message,BuildContext context)
{
  Fluttertoast.showToast(msg: message);

}
