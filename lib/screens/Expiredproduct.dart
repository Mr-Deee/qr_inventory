import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ExpiredProducts extends StatefulWidget {
  const ExpiredProducts({Key? key}) : super(key: key);

  @override
  State<ExpiredProducts> createState() => _ExpiredProductsState();
}

class _ExpiredProductsState extends State<ExpiredProducts> {
  DateTime now = new DateTime.now();

  Color _textColor = Colors.black;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);


    DateTime today = DateTime.now();
    String dateStr = "${today.year}-${today.month}-${today.day}";

    final _currentDate = DateTime.now();

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    // var searchIng = clientRequestRef.orderByChild("service_type").equalTo(
    //     Provider.of<otherUsermodel>(context, listen: false).otherinfo?.Service);
    // var ArtisanService = Provider.of<otherUsermodel>(context).otherinfo?.Service!;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(5.0),
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Expiry Data",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Brand Bold"),
                ),
                SizedBox(
                  height: 22.0,
                ),
                Divider(
                  thickness: 4.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                ),
                SizedBox(
                  // height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: 20, maxHeight: 600),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              height: size.height,
                              child: StreamBuilder(
                                  stream: _firestore
                                      .collection("products").where("ExpiryDate",  isGreaterThanOrEqualTo: dateStr)
                                      .orderBy('ExpiryDate')
                                      .snapshots(),

                                  //clientRequestRef.onValue,
                                  builder: ( BuildContext context,
                                      AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot,) {
                                    // print("$snap");

                                    if (snapshot.hasData){



                                      return Padding(
                                        padding: const EdgeInsets.all(13.0),
                                        child: ListView.builder(
                                          physics: ScrollPhysics(),
                                          itemCount:snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {

                                            print('${snapshot.data?.docs[index]['ExpiryDate']}');
                                            return Column(
                                                //  textDirection: TextDirection.ltr,
                                                verticalDirection:
                                                    VerticalDirection.down,
                                                children: <Widget>[
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3.0,
                                                            left: 0,
                                                            right: 0),

                                                    child: ExpansionTileCard(
                                                      baseColor:
                                                          Colors.cyan[50],
                                                      expandedColor:
                                                          Color(0xff48acf0),
                                                      elevation: 8,
                                                      onExpansionChanged:
                                                          (expanded) {
                                                        setState(() {
                                                          if (expanded) {
                                                            _textColor =
                                                                Colors.white;
                                                          } else {
                                                            _textColor =
                                                                Colors.black;
                                                          }
                                                        });
                                                      },
                                                      shadowColor: Colors.grey,
                                                      // shape: const RoundedRectangleBorder(
                                                      //     borderRadius: BorderRadius.all(
                                                      //       Radius.circular(20),
                                                      //     ),
                                                      //     side: BorderSide(
                                                      //         width: 2,
                                                      //         color: Colors.white38)),
                                                      //color: Colors.white,

                                                      title: ListView(
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          children: <Widget>[
                                                            //Text(Provider.of<OccupationModel>(context).Institution!,style: TextStyle(color: Colors.black),),
                                                            Column(children: [
                                                              // scrollDirection: Axis.horizontal,
                                                              Row(
                                                                children: [
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets.all(
                                                                  //           4.0),
                                                                  //   child:
                                                                  //       Column(
                                                                  //     children: [
                                                                  //       Container(
                                                                  //           width:
                                                                  //               80,
                                                                  //           height:
                                                                  //               80,
                                                                  //           decoration: BoxDecoration(
                                                                  //               border: Border.all(width: 4, color: Theme.of(context).scaffoldBackgroundColor),
                                                                  //               boxShadow: [
                                                                  //                 BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: const Offset(0, 10))
                                                                  //               ],
                                                                  //               shape: BoxShape.circle,
                                                                  //               image: const DecorationImage(
                                                                  //                   fit: BoxFit.cover,
                                                                  //                   image: NetworkImage(
                                                                  //                     "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                                                  //                   ))),
                                                                  //           child: CircleAvatar(
                                                                  //               backgroundColor: Colors.grey,
                                                                  //               radius: 70,
                                                                  //               backgroundImage: NetworkImage(
                                                                  //                 item[index]['Profilepicture'] ?? "",
                                                                  //                 //     .toString(),
                                                                  //                 // OModel[index]
                                                                  //                 //     .profilepicture
                                                                  //                 //     .toString(),
                                                                  //               ))),
                                                                  //     ],
                                                                  //   ),
                                                                  // ),
                                                                  Row(
                                                                    children: [
                                                                      Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(3.0),
                                                                            child:
                                                                                Text(
                                                                              snapshot.data?.docs[index]["group"],
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.brown),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            children: [
                                                                              Text(
                                                                                 snapshot.data?.docs[index]["ExpiryDate"] ?? "",
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(2.0),
                                                                            child:
                                                                                Text(
                                                                                  snapshot.data?.docs[index]["group"],
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: _textColor),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ])
                                                          ]),
                                                      children: <Widget>[
                                                        Divider(
                                                          thickness: 1.0,
                                                          height: 1.0,
                                                        ),
                                                        // Align(
                                                        //   alignment: Alignment
                                                        //       .centerLeft,
                                                        //   child: Padding(
                                                        //     padding:
                                                        //         const EdgeInsets
                                                        //             .symmetric(
                                                        //       horizontal: 16.0,
                                                        //       vertical: 8.0,
                                                        //     ),
                                                        //     child: Text(
                                                        //       item[index][
                                                        //               "Description"] ??
                                                        //           "",
                                                        //       style: Theme.of(
                                                        //               context)
                                                        //           .textTheme
                                                        //           .bodyText2
                                                        //           ?.copyWith(
                                                        //               fontSize:
                                                        //                   16),
                                                        //     ),
                                                        //   ),
                                                        // ),

                                                      ],
                                                    ),
                                                    // child: Container(
                                                    //     margin: EdgeInsets.symmetric(
                                                    //         vertical: 16.0),
                                                    //     decoration: BoxDecoration(
                                                    //         borderRadius: BorderRadius.only(
                                                    //             topLeft: Radius.circular(25),
                                                    //             topRight: Radius.circular(25),
                                                    //             bottomLeft:
                                                    //             Radius.circular(25),
                                                    //             bottomRight:
                                                    //             Radius.circular(25)),
                                                    //         color: Colors.white,
                                                    //         boxShadow: [
                                                    //           BoxShadow(
                                                    //               color: Colors.black38,
                                                    //               blurRadius: 6,
                                                    //               spreadRadius: 2,
                                                    //               offset: Offset(0, 1))
                                                    //         ]),
                                                    //     height: 100,
                                                    //     width: size.width,
                                                    //
                                                    //     child: Padding(
                                                    //       padding: const EdgeInsets.all(9.0),
                                                    //
                                                    //       child: Row(
                                                    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    //         children: [
                                                    //
                                                    //           Padding(
                                                    //             padding: const EdgeInsets.all(8.0),
                                                    //             child: Row(
                                                    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    //               children: [
                                                    //                 Padding(
                                                    //                   padding:
                                                    //                   const EdgeInsets.all(
                                                    //                       8.0),
                                                    //                   child: Row(
                                                    //                     children: [
                                                    //                       Column(
                                                    //                         children: [
                                                    //
                                                    //
                                                    //                           Text(
                                                    //
                                                    //                             item[index]["client_name"],
                                                    //
                                                    //                           ),
                                                    //
                                                    //                         ],
                                                    //                       ),
                                                    //
                                                    //
                                                    //
                                                    //                     ],
                                                    //                   ),
                                                    //
                                                    //
                                                    //                 ),
                                                    //
                                                    //                 //serviceType
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //               ],
                                                    //             ),
                                                    //           ),
                                                    //
                                                    //
                                                    //           Row(
                                                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    //             children: [
                                                    //               Text(
                                                    //
                                                    //                 item[index]["service_type"],
                                                    //
                                                    //               ),
                                                    //             ],
                                                    //           ),
                                                    //
                                                    //
                                                    //           Row (
                                                    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    //               children: [
                                                    //                 SizedBox(
                                                    //                   width: 60.0,
                                                    //                   height: 50.0,
                                                    //                   child: ElevatedButton(
                                                    //                     style: ElevatedButton.styleFrom(
                                                    //                       backgroundColor: Colors.white,
                                                    //                       shape: RoundedRectangleBorder(
                                                    //                           borderRadius:
                                                    //                           BorderRadius
                                                    //                               .circular(
                                                    //                               24.0),
                                                    //                           side: const BorderSide(
                                                    //                               color: Colors
                                                    //                                   .white)),),
                                                    //
                                                    //                     onPressed:
                                                    //                         () async {
                                                    //                       launch(
                                                    //                           ('tel://${data['client_phone'].toString()}'));
                                                    //                     },
                                                    //                     child: Padding(
                                                    //                       padding:
                                                    //                       const EdgeInsets
                                                    //                           .all(
                                                    //                           1.0),
                                                    //                       child:
                                                    //                       SingleChildScrollView(
                                                    //                         scrollDirection:
                                                    //                         Axis.horizontal,
                                                    //                         child: Row(
                                                    //                           mainAxisAlignment:
                                                    //                           MainAxisAlignment
                                                    //                               .spaceEvenly,
                                                    //                           children: const [
                                                    //                             Icon(
                                                    //                               Icons
                                                    //                                   .call,
                                                    //                               color: Colors
                                                    //                                   .black,
                                                    //                               size:
                                                    //                               26.0,
                                                    //                             ),
                                                    //                           ],
                                                    //                         ),
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                 ),
                                                    //               ])
                                                    //
                                                    //
                                                    //
                                                    //
                                                    //           //Phone
                                                    //
                                                    //
                                                    //         ],
                                                    //       ),
                                                    //     ))),
                                                    // Text(
                                                    //   "Client : " +
                                                    //       data["client_name"]
                                                    //           .toString(),
                                                    // ),
                                                  )
                                                ]);
                                          },
                                        ),
                                      );

                                      ///}
                                    } else {
                                      return Center(
                                          child: Text("Loading Data..."));
                                    }
                                    return CircularProgressIndicator();
                                  }

                                  //
                                  // FirebaseAnimatedList(
                                  //     query: clientRequestRef,
                                  //     itemBuilder: (BuildContext context,
                                  //         DataSnapshot snapshot,
                                  //         Animation<double> animation,
                                  //         int index) {
                                  //       return Padding(
                                  //         padding: const EdgeInsets.only(
                                  //             top: 10.0, left: 10.0, right: 10.0),
                                  //         child: ExpansionTileCard(
                                  //           baseColor: Colors.cyan[50],
                                  //           expandedColor: Color(0xff48acf0),
                                  //           elevation: 8,
                                  //           onExpansionChanged: (expanded) {
                                  //             setState(() {
                                  //               if (expanded) {
                                  //                 _textColor = Colors.white;
                                  //               } else {
                                  //                 _textColor = Colors.black;
                                  //               }
                                  //             });
                                  //           },
                                  //           shadowColor: Colors.grey,
                                  //           // shape: const RoundedRectangleBorder(
                                  //           //     borderRadius: BorderRadius.all(
                                  //           //       Radius.circular(20),
                                  //           //     ),
                                  //           //     side: BorderSide(
                                  //           //         width: 2,
                                  //           //         color: Colors.white38)),
                                  //           //color: Colors.white,
                                  //
                                  //           title: ListView(
                                  //               scrollDirection: Axis.vertical,
                                  //               physics:
                                  //               const NeverScrollableScrollPhysics(),
                                  //               shrinkWrap: true,
                                  //               padding: const EdgeInsets.all(0.0),
                                  //               children: <Widget>[
                                  //
                                  //                 Column(children: [
                                  //                   // scrollDirection: Axis.horizontal,
                                  //                   Row(
                                  //                     mainAxisAlignment:
                                  //                     MainAxisAlignment.spaceEvenly,
                                  //                     children: [
                                  //                       Padding(
                                  //                         padding:
                                  //                         const EdgeInsets.all(4.0),
                                  //                         child: Column(
                                  //                           children: [
                                  //                             Container(
                                  //                                 width: 80,
                                  //                                 height: 80,
                                  //                                 decoration:
                                  //                                 BoxDecoration(
                                  //                                   border: Border.all(
                                  //                                       width: 4,
                                  //                                       color: Theme.of(
                                  //                                           context)
                                  //                                           .scaffoldBackgroundColor),
                                  //                                   boxShadow: [
                                  //                                     BoxShadow(
                                  //                                         spreadRadius: 2,
                                  //                                         blurRadius: 10,
                                  //                                         color: Colors
                                  //                                             .black
                                  //                                             .withOpacity(
                                  //                                             0.1),
                                  //                                         offset:
                                  //                                         const Offset(
                                  //                                             0, 10))
                                  //                                   ],
                                  //                                   shape:
                                  //                                   BoxShape.circle,
                                  //                                   // image: const DecorationImage(
                                  //                                   //     fit: BoxFit.cover,
                                  //                                   //     image: NetworkImage(
                                  //                                   //       "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                  //                                   //     )
                                  //                                   // )
                                  //                                 ),
                                  //                                 // child: CircleAvatar(
                                  //                                 //   backgroundColor:
                                  //                                 //   Colors.grey,
                                  //                                 //   radius: 70,
                                  //                                 //   backgroundImage: RModel[
                                  //                                 //   index]
                                  //                                 //       .profilepicture!
                                  //                                 //       .toString() !=
                                  //                                 //       null
                                  //                                 //       ? NetworkImage(
                                  //                                 //     OModel[index]
                                  //                                 //         .profilepicture
                                  //                                 //         .toString(),
                                  //                                 //   )
                                  //                                 //       : null,
                                  //                                 // )),
                                  //                             //email
                                  //                             )],
                                  //                         ),
                                  //                       ),
                                  //                       Row(
                                  //                         children: [
                                  //                           Column(
                                  //                             children: [
                                  //                               Padding(
                                  //                                 padding:
                                  //                                 const EdgeInsets
                                  //                                     .all(3.0),
                                  //                                 child: Text(
                                  //                               rModel[index].clientname.toString(),
                                  //                                   style:
                                  //                                   TextStyle(
                                  //                                       fontWeight:
                                  //                                       FontWeight.bold,
                                  //                                       fontSize: 18,
                                  //                                       color:_textColor
                                  //                                   ),
                                  //                                 ),
                                  //                               ),
                                  //
                                  //                               // Column(
                                  //                               //   children: [
                                  //                               //     Text(OModel[
                                  //                               //     index]
                                  //                               //         .Education
                                  //                               //         .toString()),
                                  //                               //   ],
                                  //                               // ),
                                  //                             ],
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //
                                  //                     ],
                                  //                   ),
                                  //                 ])
                                  //               ]),
                                  //           children: <Widget>[
                                  //             Divider(
                                  //               thickness: 1.0,
                                  //               height: 1.0,
                                  //             ),
                                  //             // Align(
                                  //             //   alignment: Alignment.centerLeft,
                                  //             //   child: Padding(
                                  //             //     padding: const EdgeInsets.symmetric(
                                  //             //       horizontal: 16.0,
                                  //             //       vertical: 8.0,
                                  //             //     ),
                                  //             //     child: Text(
                                  //             //       OModel[index].Description.toString(),
                                  //             //       style: Theme.of(context)
                                  //             //           .textTheme
                                  //             //           .bodyText2
                                  //             //           ?.copyWith(fontSize: 16),
                                  //             //     ),
                                  //             //   ),
                                  //             // ),
                                  //             ButtonBar(
                                  //               alignment: MainAxisAlignment.spaceAround,
                                  //               buttonHeight: 52.0,
                                  //               buttonMinWidth: 90.0,
                                  //               children: <Widget>[
                                  //                 FlatButton(
                                  //                     shape: RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                         BorderRadius.circular(4.0)),
                                  //                     onPressed: () {
                                  //                       // cardA.currentState?.expand();
                                  //                     },
                                  //
                                  //
                                  //                     //phone
                                  //                     child:     Row(
                                  //                       children: [
                                  //                         Padding(
                                  //                             padding:
                                  //                             const EdgeInsets.all(
                                  //                                 1.0),
                                  //                             child: Row(
                                  //                                 mainAxisAlignment:
                                  //                                 MainAxisAlignment
                                  //                                     .spaceEvenly,
                                  //                                 children: [
                                  //                                   SizedBox(
                                  //                                     width: 60.0,
                                  //                                     height: 50.0,
                                  //                                     child:
                                  //                                     RaisedButton(
                                  //                                       color: Colors
                                  //                                           .blue,
                                  //                                       shape: RoundedRectangleBorder(
                                  //                                           borderRadius:
                                  //                                           BorderRadius.circular(
                                  //                                               24.0),
                                  //                                           side: const BorderSide(
                                  //                                               color: Colors
                                  //                                                   .blueAccent)),
                                  //                                       onPressed:
                                  //                                           () async {
                                  //                                         launch(
                                  //                                             ('tel://${rModel[index].phone}'));
                                  //                                       },
                                  //                                       child: Padding(
                                  //                                         padding:
                                  //                                         const EdgeInsets
                                  //                                             .all(
                                  //                                             1.0),
                                  //                                         child:
                                  //                                         SingleChildScrollView(
                                  //                                           scrollDirection:
                                  //                                           Axis.horizontal,
                                  //                                           child: Row(
                                  //                                             mainAxisAlignment:
                                  //                                             MainAxisAlignment
                                  //                                                 .spaceEvenly,
                                  //                                             children: const [
                                  //                                               Icon(
                                  //                                                 Icons
                                  //                                                     .call,
                                  //                                                 color:
                                  //                                                 Colors.black,
                                  //                                                 size:
                                  //                                                 26.0,
                                  //                                               ),
                                  //                                             ],
                                  //                                           ),
                                  //                                         ),
                                  //                                       ),
                                  //                                     ),
                                  //                                   )
                                  //                                 ])),
                                  //                       ],
                                  //                     )
                                  //                 ),
                                  //                 FlatButton(
                                  //                   shape: RoundedRectangleBorder(
                                  //                       borderRadius:
                                  //                       BorderRadius.circular(4.0)),
                                  //                   onPressed: () {
                                  //                     //cardA.currentState?.collapse();
                                  //                   },
                                  //                   child: Column(
                                  //                     children: <Widget>[
                                  //                       Icon(Icons.location_on, color:Colors.white),
                                  //                       Padding(
                                  //                         padding:
                                  //                         const EdgeInsets.symmetric(
                                  //                             vertical: 2.0),
                                  //                       ),
                                  //                       // SingleChildScrollView(
                                  //                       //   scrollDirection: Axis.vertical,
                                  //                       //   child: Container(
                                  //                       //     height: 39,
                                  //                       //     width:100,
                                  //                       //     child: Text( OModel[index].location.toString(),
                                  //                       //       style: const TextStyle(color: Colors.white),
                                  //                       //     ),
                                  //                       //   ),
                                  //                       // ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 FlatButton(
                                  //                   shape: RoundedRectangleBorder(
                                  //                       borderRadius:
                                  //                       BorderRadius.circular(4.0)),
                                  //                   onPressed: () {
                                  //                     // setState(() {
                                  //                     //
                                  //                     //   state = "requesting";
                                  //                     //   artianType = "bike";
                                  //                     //
                                  //                     // });
                                  //
                                  //                     showDialog(
                                  //                         context: context,
                                  //                         barrierDismissible: false,
                                  //                         builder: (BuildContext context) => homePage());
                                  //
                                  //
                                  //                   },
                                  //                   child: Column(
                                  //                     children: <Widget>[
                                  //                       Icon(Icons.work,color: Colors.white,),
                                  //                       Padding(
                                  //                         padding:
                                  //                         const EdgeInsets.symmetric(
                                  //                             vertical: 2.0),
                                  //                       ),
                                  //                       Text('Request', style: TextStyle(color: Colors.white),),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       );
                                  //     }),
                                  ),

                              // const SizedBox(
                              //   height: 10,
                              // ),
                            ),
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
