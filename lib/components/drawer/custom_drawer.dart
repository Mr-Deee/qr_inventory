import 'dart:ui';


import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import '../../screens/Expiredproduct.dart';
import '../../screens/ProfilePage.dart';
import '../../screens/home.dart';
import 'Top_user_info.dart';
import 'custom_list_tile.dart';
import 'header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),

        width: 300,
        margin: const EdgeInsets.only(bottom: 30, top: 70),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          //color: Color.fromRGBO(20, 20, 20, 1),
          color: const Color(0xffcae8ff),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.black,
              ),
             CustomListTile(
                  //isCollapsed: _isCollapsed,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  infoCount: 0, ontap: () {   Navigator.push(
                 context,
                 MaterialPageRoute(
                     builder: (context) =>  HomeScreen ())); },
                ),

              CustomListTile(
                //isCollapsed: _isCollapsed,
                icon: Icons.person,
                title: 'Profile',
                infoCount: 0, ontap: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  Profilepage ()));  },
              ),

              CustomListTile(
               // isCollapsed: _isCollapsed,
                icon: Icons.calendar_month,
                title: 'Expiry',
                infoCount: 8, ontap: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExpiredProducts()));  },
              ),

              CustomListTile(
                //isCollapsed: _isCollapsed,
                icon: Icons.settings,
                title: 'Settings',
                infoCount: 0, ontap: () {Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ExpiredProducts()));  },
              ),


              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                //isCollapsed: _isCollapsed,
                icon: Icons.help,
                title: 'About',
                infoCount: 0,
                ontap: () {  },
              ),
              // CustomListTile(
              //   isCollapsed: _isCollapsed,
              //   icon: Icons.settings,
              //   title: 'Settings',
              //   infoCount: 0, ontap: () {  },
              // ),
              const SizedBox(height: 10),


            ],
          ),
        ),
      ),
    );
  }
}
