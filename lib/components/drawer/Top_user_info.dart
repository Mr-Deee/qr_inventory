import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Users.dart';
import '../../screens/loginScreen.dart';


class BottomUserInfo extends StatelessWidget {
  final bool isCollapsed;

  const BottomUserInfo({
    Key? key,
    required this.isCollapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {


    Future<void> _showMyDialog() async {
      return showDialog<void>(
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
                      context,'/registration', (route) => false);
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
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isCollapsed ? 70 : 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isCollapsed
          ? Center(
              child: Row(
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //       margin: const EdgeInsets.symmetric(horizontal: 10),
                  //       width: 40,
                  //       height: 40,
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey,
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //       child: CircleAvatar(
                  //         backgroundColor: Colors.grey,
                  //         radius: 70,
                  //         backgroundImage: Provider.of<Users>(context)
                  //                     .userInfo
                  //                     ?.profilepicture !=
                  //                 null
                  //             ? NetworkImage(
                  //                 Provider.of<Users>(context)
                  //                     .userInfo!
                  //                     .profilepicture!,
                  //               )
                  //             : null,
                  //       )),
                  // ),
                  // Expanded(
                  //   flex: 5,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(1.0),
                  //         child: Expanded(
                  //           child: Align(
                  //             alignment: Alignment.topLeft,
                  //             child: Container(
                  //               // physics: NeverScrollableScrollPhysics(),
                  //               child: Column(
                  //                 children: [
                  //                   Text(
                  //                     '',
                  //                     style:
                  //                         Theme.of(context).textTheme.caption,
                  //                   ),
                  //                   if (Provider.of<Users>(context)
                  //                           .userInfo
                  //                           ?.firstname !=
                  //                       null)
                  //                     Text(
                  //                       Provider.of<Users>(context)
                  //                           .userInfo!
                  //                           .firstname!,
                  //                       style: TextStyle(
                  //                         color: Colors.black,
                  //                         fontWeight: FontWeight.bold,
                  //                         fontSize: 18,
                  //                       ),
                  //                       maxLines: 1,
                  //                       overflow: TextOverflow.clip,
                  //                     ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //       // Expanded(
                  //       //   child: GestureDetector(
                  //       //     onTap: () {
                  //       //       Navigator.push(
                  //       //           context,
                  //       //           MaterialPageRoute(
                  //       //               builder: (context) =>
                  //       //                   const Profilepage()));
                  //       //     },
                  //       //     child: Text(
                  //       //       'Profile',
                  //       //       style: TextStyle(
                  //       //         color: Colors.lightBlue,
                  //       //       ),
                  //       //       maxLines: 1,
                  //       //       overflow: TextOverflow.ellipsis,
                  //       //     ),
                  //       //   ),
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
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
                                          context,
                                          '/login' , (route) => false);
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Expanded(
                //   child: Container(
                //       margin: const EdgeInsets.only(top: 10),
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //         color: Colors.grey,
                //         borderRadius: BorderRadius.circular(20),
                //       ),
                //       child: CircleAvatar(
                //         backgroundColor: Colors.grey,
                //         radius: 70,
                //         backgroundImage: Provider.of<Users>(context)
                //                     .userInfo
                //                     ?.profilepicture !=
                //                 null
                //             ? NetworkImage(
                //                 Provider.of<Users>(context)
                //                     .userInfo!
                //                     .profilepicture!,
                //               )
                //             : null,
                //       )),
                // ),
                Expanded(
                  child: IconButton(
                    onPressed: () {    _showMyDialog();},
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
    );
  }


  Future<String> getPicture() async {
    User? user = await FirebaseAuth.instance.currentUser;
    return FirebaseDatabase.instance
        .reference()
        .child('Artisans')
        .child(user!.uid)
        .once()
        .then((DatabaseEvent event) {
      var data;
      data = event.snapshot.value;
      return data['profilepicture'].toString();
    });
  }
}
