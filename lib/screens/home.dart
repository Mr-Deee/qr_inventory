import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_inventory/screens/qrcode.dart';
import 'package:qr_inventory/screens/scanner.dart';
import 'package:qr_inventory/screens/sidebar.dart';


import '../constants.dart';
import '../functions/toast.dart';
import '../models/product.dart';
import '../utils/color_palette.dart';
import '../widgets/product_card.dart';
import '../widgets/product_group_card.dart';
import 'barcode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _newProductGroup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcae8ff),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text(
          appName,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu_open_sharp,
              size: 30.0,
            ),
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
          )
        ],
      ),
      endDrawer: const Sidebar(),
      body: Container(
        padding: const EdgeInsets.all(1),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Column(
            //   children: [
            //     Image.asset(
            //       "assets/logo.png",
            //       height: 180,
            //       width: 180,
            //     ),
            //     const SizedBox(height: 10),
            //     Text(
            //       appName,
            //       style: TextStyle(
            //         color: darkTextColor,
            //         fontSize: 24,
            //       ),
            //     ),
            //     const SizedBox(height: 5),
            //     Text(
            //       "Scanner | Generator",
            //       style: TextStyle(
            //         color: lightTextColor,
            //         fontSize: 20,
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration:  BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(
                            context)
                            .scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors
                              .black
                              .withOpacity(
                              0.1),
                          offset:
                          const Offset(
                              0, 10))
                    ],
                    shape:
                    BoxShape.circle,
                    // image: const DecorationImage(
                    //     fit: BoxFit.cover,
                    //     image: NetworkImage(
                    //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    //     )
                    // )
                  ),

                ),
                Text("GOOD MORNING SIR",style: TextStyle(fontWeight: FontWeight.bold),),

                FloatingActionButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            "Add Product Group",
                            style: TextStyle(fontFamily: "Nunito"),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ColorPalette.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: const Offset(0, 3),
                                      blurRadius: 6,
                                      color: const Color(0xff000000).withOpacity(0.16),
                                    ),
                                  ],
                                ),
                                height: 50,
                                child: TextField(
                                  textInputAction: TextInputAction.next,
                                  key: UniqueKey(),
                                  controller: _newProductGroup,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 16,
                                    color: ColorPalette.nileBlue,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Product Group Name",
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    hintStyle: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 16,
                                      color: ColorPalette.nileBlue.withOpacity(0.58),
                                    ),
                                  ),
                                  cursorColor: ColorPalette.timberGreen,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_newProductGroup.text != null &&
                                      _newProductGroup.text != "") {
                                    try {
                                      final DocumentSnapshot<Map<String, dynamic>>
                                      _doc = await _firestore
                                          .collection("utils")
                                          .doc("productGroups")
                                          .get();
                                      final List<dynamic> _tempList =
                                      _doc.data()!['list'] as List<dynamic>;
                                      if (_tempList.contains(_newProductGroup.text)) {
                                        showTextToast("Group Name already created");
                                      } else {
                                        _tempList.add(_newProductGroup.text);
                                        _firestore
                                            .collection('utils')
                                            .doc("productGroups")
                                            .update({'list': _tempList});
                                        showTextToast("Added Successfully");
                                      }
                                    } catch (e) {
                                      showTextToast("An Error Occured!");
                                    }
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                    _newProductGroup.text = "";
                                  } else {
                                    showTextToast("Enter Valid Name!");
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ColorPalette.pacificBlue,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 3),
                                        blurRadius: 6,
                                        color:
                                        const Color(0xff000000).withOpacity(0.16),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Done",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: "Nunito",
                                        color: ColorPalette.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  splashColor: ColorPalette.bondyBlue,
                  backgroundColor: ColorPalette.pacificBlue,
                  child: const Icon(
                    Icons.add,
                    color: ColorPalette.white,
                  ),
                ),      //: null,



            ]),

            Column(

              children:[


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                 decoration:  BoxDecoration(
                    border: Border.all(
                                                            width: 4,
                                                            color: Theme.of(
                                                                context)
                                                                .scaffoldBackgroundColor),
                                                        boxShadow: [
                                                          BoxShadow(
                                                              spreadRadius: 2,
                                                              blurRadius: 10,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                  0.1),
                                                              offset:
                                                              const Offset(
                                                                  0, 10))
                                                        ],
                                                        shape:
                                                        BoxShape.rectangle,
                                                        // image: const DecorationImage(
                                                        //     fit: BoxFit.cover,
                                                        //     image: NetworkImage(
                                                        //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                                        //     )
                                                        // )
                                                      ),
                  child:    Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                            const Text(
                              "Product Groups",
                              style: TextStyle(
                                color: ColorPalette.timberGreen,
                                fontSize: 20,
                                fontFamily: "Nunito",
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: StreamBuilder(
                                stream:
                                _firestore.collection("utils").snapshots(),
                                builder: (
                                    BuildContext context,
                                    AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot,
                                    ) {
                                  if (snapshot.hasData) {
                                    final List<dynamic> _productGroups =
                                    snapshot.data!.docs[0].data()['list']
                                    as List<dynamic>;
                                    _productGroups.sort();
                                    return GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 2,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20,
                                      ),
                                      itemCount: _productGroups.length,
                                      itemBuilder: (context, index) {
                                        return ProductGroupCard(
                                          name: _productGroups[index] as String,
                                          key: UniqueKey(),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(
                                          color: ColorPalette.pacificBlue,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ),
              )
         ]   ),



            // OutlinedButton(
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Text(
            //       "Exit Application",
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: buttonColor,
            //       ),
            //     ),
            //   ),
            //   style: OutlinedButton.styleFrom(
            //     side: BorderSide(
            //       width: 0.9,
            //       color: buttonColor,
            //     ),
            //   ),
            //   onPressed: () {
            //     SystemNavigator.pop();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
