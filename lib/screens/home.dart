import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_inventory/screens/addproduct.dart';


import '../components/drawer/custom_drawer.dart';
import '../constants.dart';
import '../functions/toast.dart';
import '../models/Users.dart';
import '../models/assistantmethods.dart';
import '../models/product.dart';
import '../utils/color_palette.dart';
import '../widgets/product_card.dart';
import '../widgets/product_group_card.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
FirebaseFirestore db = FirebaseFirestore.instance;
String?docID;
getproducts()async{

  QuerySnapshot querySnapshot = (await db
      .collection('products')
      .doc(docID)
      .collection('ExpiryDate')
      .get()) ;
  return querySnapshot;
}

getCurrentDate() {
  var date = DateTime.now().toString();

  var dateParse = DateTime.parse(date);

  var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
print(formattedDate);
print(newProduct.Expiry);
  return formattedDate;
}
class _HomeScreenState extends State<HomeScreen> {
  final Product newProduct = Product();


  String messageTitle = "Empty";
  String notificationAlert = "alert";

  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    getCurrentDate();
    getproducts();
    if(newProduct.Expiry==newProduct.Expiry){

print(db);
print(getproducts());
print("ssssssssssss");

    }

    // if (newProduct.Expiry == getCurrentDate()) {
    //   FirebaseMessaging? _firebaseMessaging;
    //   _firebaseMessaging?.getToken().then((token) {
    //     print("token is $token");
    //     print(getCurrentDate());
    //   });
    // }

    // push notification


    super.initState();


    AssistantMethod.getCurrentOnlineUserInfo(context);
  }


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _newProductGroup = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;


    var firstname = Provider.of<Users>(context).userInfo?.firstname!;
    return Scaffold(
      backgroundColor: const Color(0xffcae8ff),
      key: _scaffoldKey,
      //   drawer:  IconButton(
      //   icon: const Icon(
      //     Icons.menu_open_sharp,
      //     size: 30.0,
      //   ),
      //   onPressed: () {
      //     _scaffoldKey.currentState!.openEndDrawer();
      //   },
      // ),
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
                Icons.power_settings_new,
                color: ColorPalette.timberGreen,
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      title: Text('Sign Out'),
                      backgroundColor: Colors.white,
                      content: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Text(
                                'Are you certain you want to Sign Out?'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                color: Colors.black),
                          ),
                          onPressed: () {
                            print('yes');
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/login',
                                    (route) => false);
                            // Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text(
                            'Cancel',
                            style:
                            TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }),
        ],
      ),
      drawer:CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(1),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(19.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          // image: const DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(
                          //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                          //     )
                          // )
                        ),
                      ),
                      Text(
                        "GOOD MORNING "+firstname!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

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
                                            color: const Color(0xff000000)
                                                .withOpacity(0.16),
                                          ),
                                        ],
                                      ),
                                      height: 60,
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
                                            color: ColorPalette.nileBlue
                                                .withOpacity(0.58),
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
                                            final DocumentSnapshot<
                                                Map<String, dynamic>> _doc =
                                            await _firestore
                                                .collection("utils")
                                                .doc("productGroups")
                                                .get();
                                            final List<dynamic> _tempList =
                                            _doc.data()!['list']
                                            as List<dynamic>;
                                            if (_tempList.contains(
                                                _newProductGroup.text)) {
                                              showTextToast(
                                                  "Group Name already created");
                                            } else {
                                              _tempList
                                                  .add(_newProductGroup.text);
                                              _firestore
                                                  .collection('utils')
                                                  .doc("productGroups")
                                                  .update({'list': _tempList});
                                              showTextToast(
                                                  "Added Successfully");
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
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: ColorPalette.pacificBlue,
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 3),
                                              blurRadius: 6,
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.16),
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
                        backgroundColor: Colors.amber,
                        child: const Icon(
                          Icons.add,
                          color: Colors.black54,
                        ),
                      ), //: null,
                    ]),
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: height / 0.99,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(20),
                      color: const Color(0xffcae8ff),
                      border: Border.all(
                        width: 4,
                        color: const Color(0xffcae8ff),),


                      //Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.rectangle,
                      // image: const DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: NetworkImage(
                      //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                      //     )
                      // )
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                                      stream: _firestore
                                          .collection("utils")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                              QuerySnapshot<Map<String, dynamic>>>
                                          snapshot,) {
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
                                                name:
                                                _productGroups[index] as String,
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
                      ],
                    ),
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}




