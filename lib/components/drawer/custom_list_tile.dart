import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  // final bool isCollapsed;
  final IconData icon;
  final String title;
  final IconData? doHaveMoreOptions;
  final VoidCallback ontap;
  final int infoCount;

  const CustomListTile({
    Key? key,
    // required this.isCollapsed,
    required this.icon,
    required this.title,
    this.doHaveMoreOptions,
    required this.infoCount, required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width:   300 ,
        height: 80,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      icon,
                      color: Colors.black,
                    ),
                    if (infoCount > 0)
                      Positioned(
                        right: -5,
                        top: -5,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
             const SizedBox(width: 10),

              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    if (infoCount > 0)
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple[200],
                          ),
                          child: Center(
                            child: Text(
                              infoCount.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              Expanded(
                flex: 1,
                child: doHaveMoreOptions != null
                    ? IconButton(
                        icon: Icon(
                          doHaveMoreOptions,
                          color: Colors.white,
                          size: 12,
                        ),
                        onPressed: () {},
                      )
                    : const Center(),
              ),
          ],
        ),
      ),
    );
  }
}
