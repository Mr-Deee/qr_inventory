import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_inventory/screens/qrcode.dart';
import 'package:qr_inventory/screens/scanner.dart';

import '../constants.dart';
import 'about.dart';
import 'barcode.dart';
import 'home.dart';
import 'loginScreen.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: Image.asset("assets/logo.png"),
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: darkTextColor,
          ),
          ListTile(
            leading: Icon(
              Icons.home_outlined,
              color: darkTextColor,
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: darkTextColor,
            ),
            title: Text(
              'Scan Codes',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  ScanScreen(),
                ),
              ),
            },
          ),
          ListTile(
            leading: Icon(
              Icons.qr_code,
              color: darkTextColor,
            ),
            title: Text(
              'Generate QR code',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const QrCodeGenerationScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.view_quilt,
              color: darkTextColor,
            ),
            title: Text(
              'Generate Barcode',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarcodeGenerationScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.android,
              color: darkTextColor,
            ),
            title: Text(
              'About Me',
              style: TextStyle(
                color: darkTextColor,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsScreen(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Expanded(
              child: IconButton(
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Sign Out'),
                        backgroundColor: Colors.white,
                        content: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text('Are you certain you want to Sign Out?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Yes',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              print('yes');
                              FirebaseAuth.instance.signOut();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                              // Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 48,
                ),

              ),
            ),
          ),
          Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: darkTextColor,
          ),
        ],
      ),
    );
  }
}
