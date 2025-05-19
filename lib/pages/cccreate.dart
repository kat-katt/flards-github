import 'package:flutter/material.dart';

class Cccreate extends StatelessWidget {
  const Cccreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 390,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Positioned(
                  left: 95,
                  top: 200,
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/back.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 105,
                  top: 210,
                  child: Container(
                    width: 23,
                    height: 19,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/create set.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 137,
                  top: 240,
                  child: SizedBox(
                    width: 137,
                    height: 53,
                    child: Text(
                      'Create ',
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 40,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 97,
                  top: 304,
                  child: GestureDetector(
                    onTap: () {
                      // Add your new set creation logic here
                      print('New Set tapped');
                    },
                    child: Container(
                      width: 211,
                      height: 53,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD1E5FE),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: const Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 8,
                            child: Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/create set.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 65,
                            top: 10,
                            child: SizedBox(
                              width: 136,
                              height: 34,
                              child: Text(
                                'New set',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF081D5C),
                                  fontSize: 25,
                                  fontFamily: 'OPTIFrankfurter-Medium',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 97,
                  top: 375,
                  child: GestureDetector(
                    onTap: () {
                      // Add your new folder creation logic here
                      print('New Folder tapped');
                    },
                    child: Container(
                      width: 211,
                      height: 53,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFD1E5FE),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 2,
                            color: const Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 10,
                            child: Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/create folder.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 65,
                            top: 10,
                            child: SizedBox(
                              width: 136,
                              height: 34,
                              child: Text(
                                'New folder',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xFF081D5C),
                                  fontSize: 25,
                                  fontFamily: 'OPTIFrankfurter-Medium',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
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
        ],
      ),
    );
  }
}
