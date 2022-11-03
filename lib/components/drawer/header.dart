import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Top_user_info.dart';

class CustomDrawerHeader extends StatelessWidget {
  final bool isColapsed;


  const CustomDrawerHeader({
    Key? key,
    required this.isColapsed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // AnimatedContainer(
        //   duration: const Duration(milliseconds: 500),
        //   height: 60,
        //   width: double.infinity,
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: SingleChildScrollView(
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           //const FlutterLogo(size: 30),
        //           if (isColapsed) const SizedBox(width: 10),
        //           if (isColapsed)
        //             Column(
        //               children: [
        //                Padding(
        //                  padding: const EdgeInsets.all(8.0),
        //                  child: Expanded(
        //                     flex: 3,
        //
        //                     child: Text(
        //                       'TimeUp',
        //                       style: TextStyle(
        //                         color: Colors.black,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 20,
        //                       ),
        //                       maxLines: 1,
        //                     ),
        //                   ),
        //                ),
        //               ],
        //             ),
        //           if (isColapsed) const Spacer(),
        //           // if (isColapsed)
        //           //   Expanded(
        //           //
        //           //     flex: 1,
        //           //     child: IconButton(
        //           //       onPressed: () {},
        //           //       icon: const Icon(
        //           //         Icons.search,
        //           //         color: Colors.black,
        //           //       ),
        //           //     ),
        //           //   ),
        //
        //
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        // AnimatedContainer(
        //   height: 60,
        //   width: double.infinity,
        //   duration: const Duration(milliseconds: 500),
        //
        //
        //       child: BottomUserInfo(isCollapsed: isColapsed)),

      ],
    );
  }
}
