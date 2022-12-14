import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_inventory/screens/addproduct.dart';
import 'package:qr_inventory/screens/scanner.dart';

import '../models/product.dart';
import '../utils/color_palette.dart';
import '../widgets/product_card.dart';




class ProductGroupPage extends StatelessWidget {
  final String? name;
  ProductGroupPage({Key? key, this.name}) : super(key: key);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:


      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              right: 10,
              left: 100
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return NewProductPage(
                        group: name,
                      );
                    },
                  ),
                );
              },
              splashColor: ColorPalette.bondyBlue,
              backgroundColor:Colors.amber,
              child: const Icon(
                Icons.add,
                color: ColorPalette.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10,
                right: 10,
                left: 100
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ScanScreen(
                        group: name,
                      );
                    },
                  ),
                );
              },
              splashColor: ColorPalette.bondyBlue,
              backgroundColor:Colors.amber,
              child: const Icon(
                Icons.qr_code,
                color: ColorPalette.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color:Colors.amber,
        child: SafeArea(
          child: Container(
            color:  const Color(0xffcae8ff),
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
                    color:Colors.amber,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                          Text(
                            name!.length > 14
                                ? '${name!.substring(0, 12)}..'
                                : name!,
                            style: const TextStyle(
                              fontFamily: "Nunito",
                              fontSize: 28,
                              color: ColorPalette.timberGreen,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            splashColor: ColorPalette.timberGreen,
                            icon: const Icon(
                              Icons.search,
                              color: ColorPalette.timberGreen,
                            ),
                            onPressed: () {
                             // Navigator.of(context).push(
                                // MaterialPageRoute(
                                //   builder: (context) =>
                                //       SearchProductInGroupPage(
                                //     name: name,
                                //   ),
                                // ),
                             // );
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: ColorPalette.timberGreen,
                            ),
                            onPressed: () {
                              //TODO
                            },
                          ),
                        ],
                      )
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
                           Text(
                            name!,
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
                                  .collection("products")
                                  .where("group",isEqualTo: name)

                                  .snapshots(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot,
                              ) {
                                if (!snapshot.hasData) {
                                  return  Center(
                                    child: SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                      ),
                                    ),
                                  );
                                }
                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ProductCard(
                                      product: Product.fromMap(
                                        snapshot.data!.docs[index].data(),
                                      ),
                                      docID: snapshot.data!.docs[index].id,
                                    );
                                  },
                                );

                              },
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
