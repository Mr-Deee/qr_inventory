import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../constants.dart';
import '../functions/toast.dart';
import '../models/product.dart';
import '../utils/color_palette.dart';
import '../widgets/location_drop_down.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product? product;
  final String? docID;
  String?group;
  ProductDetailsPage({Key? key, this.product, this.group, this.docID}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState(group, docID,product);
}
class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final Product newProduct = Product();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String?docID;

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
  Product? product;
  String?group;

  _ProductDetailsPageState(this.group,this.docID,this.product);


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
            _firestore
                .collection("products")
                .doc(docID)
                .update(product!.toMap())
                .then((value) {
              showTextToast('Updated Sucessfully!');
            }).catchError((e) {
              showTextToast('Failed!');
            });
            Navigator.of(context).pop();
          },
          splashColor: ColorPalette.bondyBlue,
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.done,
            color: ColorPalette.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.amber,
        child: SafeArea(
          child: Container(
            color: Colors.amber,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 15,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: const BoxDecoration(
                        color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              size: 35,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          const Text(
                            "Edit Product",
                            style: TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              color: ColorPalette.timberGreen,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: ColorPalette.timberGreen,
                        ),
                        onPressed: () {
                          _firestore
                              .collection("products")
                              .doc(docID)
                              .delete()
                              .then((value) {
                            showTextToast('Deleted Sucessfully!');
                          }).catchError((e) {
                            showTextToast('Failed!');
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
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
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 50,
                                  ),
                                  margin: const EdgeInsets.only(top: 75),
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
                                            "Product Group : ${product!.group}",
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
                                            initialValue: product!.name ?? '',
                                            onChanged: (value) {
                                              product!.name = value;
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
                                                  initialValue: product!.cost ==
                                                          null
                                                      ? ''
                                                      : product!.cost.toString(),
                                                  onChanged: (value) {
                                                    product!.cost =
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
                                                      product!.quantity == null
                                                          ? ''
                                                          : product!.quantity
                                                              .toString(),
                                                  onChanged: (value) {
                                                    product!.quantity =
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
                                            initialValue: product!.company ?? '',
                                            onChanged: (value) {
                                              product!.company = value;
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
                                              hintText: "Company",
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
                                                product!.description ?? '',
                                            onChanged: (value) {
                                              product!.description = value;
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
                                        const SizedBox(
                                          height: 20,
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
                                                product!.barcode ?? '',
                                            onChanged: (value) {
                                              product!.barcode = value;
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
                                              hintText: "Barcode",
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



                                        // const Padding(
                                        //   padding: EdgeInsets.only(
                                        //     left: 8,
                                        //     bottom: 5,
                                        //   ),
                                        //   child: Text(
                                        //     "Location",
                                        //     style: TextStyle(
                                        //       fontFamily: "Nunito",
                                        //       fontSize: 14,
                                        //       color: ColorPalette.nileBlue,
                                        //     ),
                                        //   ),
                                        // ),
                                        // LocationDD(product: product),
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
