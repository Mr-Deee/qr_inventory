import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_inventory/screens/Registration.dart';
import 'package:qr_inventory/screens/home.dart';
import 'package:qr_inventory/screens/loginScreen.dart';
import 'package:qr_inventory/screens/product_details_page.dart';
import 'package:qr_inventory/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


DatabaseReference userRef = FirebaseDatabase.instance.reference().child("Users");

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     // home: const XplashXcreen(),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? '/login'
          : '/home',
      routes:
      {

        '/registration': (context) => RegistrationScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/product_details':(context)=>ProductDetailsPage(),




      },


    );
  }
}

