import 'package:barcode_scanner/classical_components/barcode_camera.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:qr_inventory/screens/qrcode.dart';

import 'package:qr_inventory/screens/sidebar.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../functions/toast.dart';
import '../models/addedproduct.dart';
import '../utils/color_palette.dart';
import '../widgets/location_drop_down.dart';
import 'home.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key, this.group, })
      : super(key: key);
  final String? group;


  @override
  State<ScanScreen> createState() => _ScanScreenState(group);
}

class _ScanScreenState extends State<ScanScreen> {


  final Product newProduct = Product();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController dateInput = TextEditingController();
  String? group;

  _ScanScreenState(this.group);

  final ImagePicker _picker = ImagePicker();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MobileScannerController cameraController = MobileScannerController();

  Future pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
    } else {
      cameraController.analyzeImage(pickedImage.path);
    }
  }

  bool isUrl = false;

  String _scanBarcode = '';

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      newProduct.barcode = barcodeScanRes;
    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
          right: 10,
        ),
        child: FloatingActionButton(
          onPressed: () {
            newProduct.group = group;
            _firestore
                .collection("products")
                .add(newProduct.toMap())
                .then((value) {
              showTextToast('Added Sucessfully!');
            }).catchError((e) {
              showTextToast('Failed!');
            });
            Navigator.of(context).pop();
          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: ColorPalette.pacificBlue,
          child: const Icon(
            Icons.done,
            color: ColorPalette.white,
          ),
        ),
      ),
      backgroundColor: bgColor,
      key: _scaffoldKey,
      endDrawer: const Sidebar(),
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_open_sharp,
            size: 30.0,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openEndDrawer();
          },
        ),
        title: const Text(
          appName,
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        actions: [

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
        color: ColorPalette.pacificBlue,
        child: SafeArea(
          child: Container(
            color: ColorPalette.aquaHaze,
            height: double.infinity,
            width: double.infinity,
            child: Column(
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
                          Expanded(
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Scan",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: lightTextColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        LoadingAnimationWidget
                                            .horizontalRotatingDots(
                                          color: lightTextColor,
                                          size: 35,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_sharp,
                                          size: 35,
                                          color: darkTextColor,
                                        ),
                                        Icon(
                                          Icons.search,
                                          size: 20,
                                          color: darkTextColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 90,
                                  ),
                                  margin: const EdgeInsets.only(top: 100),
                                  decoration: const BoxDecoration(
                                    color: ColorPalette.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 8,
                                            bottom: 12,
                                          ),
                                          child: Text(
                                            "Product Group : $group",
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 17,
                                              color: ColorPalette.nileBlue,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue: newProduct.name ?? '',
                                            onChanged: (value) {
                                              newProduct.name = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Product Name",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.cost == null
                                                          ? ''
                                                          : newProduct.cost
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.cost =
                                                        double.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Cost",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorPalette.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset:
                                                          const Offset(0, 3),
                                                      blurRadius: 6,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.1),
                                                    ),
                                                  ],
                                                ),
                                                height: 50,
                                                child: TextFormField(
                                                  initialValue:
                                                      newProduct.quantity ==
                                                              null
                                                          ? ''
                                                          : newProduct.quantity
                                                              .toString(),
                                                  onChanged: (value) {
                                                    newProduct.quantity =
                                                        int.parse(value);
                                                  },
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  key: UniqueKey(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  style: const TextStyle(
                                                    fontFamily: "Nunito",
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.nileBlue,
                                                  ),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Quantity",
                                                    filled: true,
                                                    fillColor:
                                                        Colors.transparent,
                                                    hintStyle: TextStyle(
                                                      fontFamily: "Nunito",
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .nileBlue
                                                          .withOpacity(0.58),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      ColorPalette.timberGreen,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),

                                         SizedBox(
                                          height: 20,
                                        ),

                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Container(


                                                decoration: BoxDecoration(
                                                    color: ColorPalette.white,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                    boxShadow: [
                                                    BoxShadow(
                                                    offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),]),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    left:38,
                                                    bottom: 5,
                                                  ),
                                                  child  :Column(

                                                    children: [


                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Icon(
                                                              Icons.qr_code_scanner_sharp,
                                                              size: 35,
                                                              color: darkTextColor,),
                                                          ),

                                                          Padding(
                                                            padding: const EdgeInsets.only(top:8.0,left:8.0),
                                                            child: Text(
                                                                newProduct.barcode ??"",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    20)

                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                       ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorPalette.white,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 3),
                                                blurRadius: 6,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.1),
                                              ),
                                            ],
                                          ),
                                          height: 50,
                                          child: TextFormField(
                                            initialValue:
                                                newProduct.description ?? '',
                                            onChanged: (value) {
                                              newProduct.description = value;
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            key: UniqueKey(),
                                            keyboardType: TextInputType.text,
                                            style: const TextStyle(
                                              fontFamily: "Nunito",
                                              fontSize: 16,
                                              color: ColorPalette.nileBlue,
                                            ),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Description",
                                              filled: true,
                                              fillColor: Colors.transparent,
                                              hintStyle: TextStyle(
                                                fontFamily: "Nunito",
                                                fontSize: 16,
                                                color: ColorPalette.nileBlue
                                                    .withOpacity(0.58),
                                              ),
                                            ),
                                            cursorColor:
                                                ColorPalette.timberGreen,
                                          ),
                                        ),
                                        const SizedBox(height: 20),



                                        TextFormField(
                                          controller: dateInput,
                                          //editing controller of this TextField
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.calendar_today), //icon of text field
                                            // labelText: "Enter Date" //label text of field
                                          ),
                                          readOnly: true,
                                          //set it true, so that user will not able to edit text
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime(2100));

                                            if (pickedDate != null) {
                                              print(
                                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                              newProduct.ExpiryDate =
                                              DateFormat('yyyy-MM-dd').format(pickedDate);
                                              print(
                                                  newProduct.ExpiryDate); //formatted date output using intl package =>  2021-03-16
                                              setState(() {
                                                dateInput.text =
                                                    newProduct.ExpiryDate!;
                                                // formattedDate=newProduct.barcode!;
                                                //set output date to TextField value.
                                              });
                                            } else {}
                                          },
                                        )
                                            // child: TextFormField(
                                            //   initialValue:
                                            //       newProduct.company ?? '',
                                            //   onChanged: (value) {
                                            //     newProduct.company = value;
                                            //   },
                                            //   textInputAction:
                                            //       TextInputAction.next,
                                            //   key: UniqueKey(),
                                            //   keyboardType: TextInputType.text,
                                            //   style: const TextStyle(
                                            //     fontFamily: "Nunito",
                                            //     fontSize: 16,
                                            //     color: ColorPalette.nileBlue,
                                            //   ),
                                            //   decoration: InputDecoration(
                                            //     border: InputBorder.none,
                                            //     hintText: "Company",
                                            //     filled: true,
                                            //     fillColor: Colors.transparent,
                                            //     hintStyle: TextStyle(
                                            //       fontFamily: "Nunito",
                                            //       fontSize: 16,
                                            //       color: ColorPalette.nileBlue
                                            //           .withOpacity(0.58),
                                            //     ),
                                            //   ),
                                            //   cursorColor:
                                            //       ColorPalette.timberGreen,



                                           // LocationDD(product: newProduct),
                                      ],
                                    ),
                                  ),
                                ),



                                GestureDetector(
                                  onTap: (){
                                    scanBarcodeNormal();

                                  },
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(11),
                                          child: Container(
                                            color: ColorPalette.white,
                                            child: Container(
                                              color: ColorPalette.timberGreen
                                                  .withOpacity(0.1),
                                              child:

                                                Padding(
                                                  padding: const EdgeInsets.only(top:30.0,left:12,right: 12),
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.qr_code_scanner_sharp,
                                                        size: 35,
                                                        color: darkTextColor,
                                                      ),

                                                    ],

                                              ),
                                                )
                                              //     : CachedNetworkImage(
                                              //   fit: BoxFit.cover,
                                              //   imageUrl: newProduct.image!,
                                              //   errorWidget:
                                              //       (context, s, a) {
                                              //     return Icon(
                                              //       Icons.image,
                                              //       color: ColorPalette
                                              //           .nileBlue
                                              //           .withOpacity(0.5),
                                              //     );
                                              //   },
                                              // ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.topCenter,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(top: 10),
                                //     child: SizedBox(
                                //       height: 100,
                                //       width: 100,
                                //       child:  Center(
                                //                     child: Container(
                                //                         alignment:
                                //                             Alignment.center,
                                //                         child: Flex(
                                //                             direction:
                                //                                 Axis.vertical,
                                //                             mainAxisAlignment:
                                //                                 MainAxisAlignment
                                //                                     .center,
                                //                             children: <Widget>[
                                //                               ElevatedButton(
                                //                                   onPressed: () =>
                                //                                       scanBarcodeNormal(),
                                //                                   child: Text(
                                //                                       'Start barcode scan')),
                                //                               // ElevatedButton(
                                //                               //     onPressed: () =>
                                //                               //         scanQR(),
                                //                               //     child: Text(
                                //                               //         'Start QR scan')),
                                //                               ElevatedButton(
                                //
                                //                                   onPressed: () =>
                                //                                       startBarcodeScanStream(),
                                //                                   child: Text(
                                //                                       'Start barcode scan stream')),
                                //
                                //                             ])))
                                //
                                //
                                //
                                //
                                //
                                //   ),
                                // ),
                                // )



                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
