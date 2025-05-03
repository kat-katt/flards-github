import 'package:flutter/material.dart';

Widget buildCardStack() {
  return SizedBox(
    width: 305,
    height: 392,
    child: Stack(
      children: [
        Positioned(
          left: 0,
          top: 33.68,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.15),
            child: Container(
              width: 226.26,
              height: 362.36,
              decoration: ShapeDecoration(
                color: Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF081D5C),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 53.90,
          top: 12.77,
          child: Container(
            width: 240.10,
            height: 357.68,
            decoration: ShapeDecoration(
              color: Color(0xFF081D5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF081D5C)),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
        ),
        Positioned(
          left: 12.25,
          top: 56.58,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.24),
            child: Container(
              width: 33.50,
              height: 35.91,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/33x36"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 74,
          top: 44,
          child: SizedBox(
            width: 204,
            height: 160,
            child: Text(
              'CSDC200 lesson 9',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 36,
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          left: 108.83,
          top: 158.32,
          child: SizedBox(
            width: 153.27,
            height: 27.87,
            child: Text(
              'parabenFree',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 20,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 74,
          top: 156,
          child: Container(
            width: 30.19,
            height: 30.19,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/30x30"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 169,
          top: 320,
          child: SizedBox(
            width: 98,
            height: 35,
            child: Text(
              '30 cards',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 24,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 392,
          top: 33.68,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.15),
            child: Container(
              width: 226.26,
              height: 362.36,
              decoration: ShapeDecoration(
                color: Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF081D5C),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 445.90,
          top: 12.77,
          child: Container(
            width: 240.10,
            height: 357.68,
            decoration: ShapeDecoration(
              color: Color(0xFF081D5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF081D5C)),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
        ),
        Positioned(
          left: 404.25,
          top: 56.58,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.24),
            child: Container(
              width: 33.50,
              height: 35.91,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/33x36"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 466,
          top: 44,
          child: SizedBox(
            width: 204,
            height: 160,
            child: Text(
              'CSDC200 lesson 10',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 36,
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          left: 500.83,
          top: 158.32,
          child: SizedBox(
            width: 153.27,
            height: 27.87,
            child: Text(
              'parabenFree',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 20,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 466,
          top: 156,
          child: Container(
            width: 30.19,
            height: 30.19,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/30x30"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 561,
          top: 320,
          child: SizedBox(
            width: 98,
            height: 35,
            child: Text(
              '17  cards',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 24,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 784,
          top: 33.68,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.15),
            child: Container(
              width: 226.26,
              height: 362.36,
              decoration: ShapeDecoration(
                color: Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF081D5C),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 837.90,
          top: 12.77,
          child: Container(
            width: 240.10,
            height: 357.68,
            decoration: ShapeDecoration(
              color: Color(0xFF081D5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF081D5C)),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
        ),
        Positioned(
          left: 796.25,
          top: 56.58,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.24),
            child: Container(
              width: 33.50,
              height: 35.91,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/33x36"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 858,
          top: 44,
          child: SizedBox(
            width: 204,
            height: 160,
            child: Text(
              'CSDC200 lesson 11',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 36,
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          left: 892.83,
          top: 158.32,
          child: SizedBox(
            width: 153.27,
            height: 27.87,
            child: Text(
              'parabenFree',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 20,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 858,
          top: 156,
          child: Container(
            width: 30.19,
            height: 30.19,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/30x30"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 953,
          top: 320,
          child: SizedBox(
            width: 98,
            height: 35,
            child: Text(
              '23 cards',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 24,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1176,
          top: 33.68,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.15),
            child: Container(
              width: 226.26,
              height: 362.36,
              decoration: ShapeDecoration(
                color: Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 4,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: Color(0xFF081D5C),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 1229.90,
          top: 12.77,
          child: Container(
            width: 240.10,
            height: 357.68,
            decoration: ShapeDecoration(
              color: Color(0xFF081D5C),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: Color(0xFF081D5C)),
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
            ),
          ),
        ),
        Positioned(
          left: 1188.25,
          top: 56.58,
          child: Transform(
            transform:
                Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-0.24),
            child: Container(
              width: 33.50,
              height: 35.91,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/33x36"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 1250,
          top: 44,
          child: SizedBox(
            width: 204,
            height: 160,
            child: Text(
              'CSDC200 lesson 12',
              style: TextStyle(
                color: Color(0xFFF5F5F5),
                fontSize: 36,
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1284.83,
          top: 158.32,
          child: SizedBox(
            width: 153.27,
            height: 27.87,
            child: Text(
              'parabenFree',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 20,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1250,
          top: 156,
          child: Container(
            width: 30.19,
            height: 30.19,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://placehold.co/30x30"),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          left: 1345,
          top: 320,
          child: SizedBox(
            width: 98,
            height: 35,
            child: Text(
              '45 cards',
              style: TextStyle(
                color: Color(0xFFFFF6ED),
                fontSize: 24,
                fontFamily: 'Questrial',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
