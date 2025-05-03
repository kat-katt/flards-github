import 'package:flard/pages/code_verify.dart';
import 'package:flard/pages/sign_in.dart';
import 'package:flutter/material.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 391,
          height: 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFFFFF6ED)),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: -52,
                child: Container(
                  width: 390,
                  height: 956,
                  decoration: ShapeDecoration(
                    gradient: RadialGradient(
                      center: Alignment(0.10, 0.37),
                      radius: 1.60,
                      colors: [
                        const Color(0xFF344EAF),
                        const Color(0xFF6F96D1),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(57),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 66,
                top: 217,
                child: SizedBox(
                  width: 277,
                  height: 30,
                  child: Text(
                    'The best digital flashcard app.',
                    style: TextStyle(
                      color: const Color(0xFFD1E5FE),
                      fontSize: 20,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -243,
                top: 633.39,
                child: Container(
                  transform:
                      Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.84),
                  width: 144.34,
                  height: 588,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD1E5FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -198.80,
                top: 510.86,
                child: Container(
                  transform:
                      Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.63),
                  width: 144.34,
                  height: 588,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF6ED),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -87,
                top: 403.53,
                child: Container(
                  transform:
                      Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.29),
                  width: 144.34,
                  height: 588,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD1E5FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -42,
                top: 318.03,
                child: Container(
                  transform:
                      Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.17),
                  width: 365,
                  height: 588,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF6ED),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 282.68,
                child: Container(
                  width: 365,
                  height: 588,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFD1E5FE),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: const Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(56),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 36,
                top: 80,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignIn()),
                    );
                  },
                  child: Container(
                    width: 319,
                    height: 126,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 65,
                top: 369,
                child: SizedBox(
                  width: 200,
                  child: Text(
                    'New \npassword',
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
                left: 60,
                top: 303,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => CodeVerify()),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/eye.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 481,
                child: Text(
                  'Enter new password',
                  style: TextStyle(
                    color: const Color(0xFF081D5C),
                    fontSize: 14,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 101,
                top: 686,
                child: Container(
                  width: 216,
                  height: 40,
                  decoration: ShapeDecoration(
                    gradient: RadialGradient(
                      center: Alignment(1.23, -0.17),
                      radius: 5.88,
                      colors: [
                        const Color(0xFF344EAF),
                        const Color(0xFF6F96D1),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 160,
                top: 692,
                child: SizedBox(
                  width: 125,
                  height: 30,
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: const Color(0xFFFFF6ED),
                      fontSize: 24,
                      fontFamily: 'OPTIFrankfurter-Medium',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 306,
                top: 513,
                child: Container(
                  width: 22,
                  height: 16,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/hidden.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 70,
                top: 563,
                child: Text(
                  'Confirm password',
                  style: TextStyle(
                    color: const Color(0xFF081D5C),
                    fontSize: 14,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 306,
                top: 595,
                child: Container(
                  width: 22,
                  height: 16,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/hidden.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 508,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 278,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF000000),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            "assets/hidden.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                        hintText: 'New password',
                        hintStyle: TextStyle(
                          color: const Color(0xFF081D5C).withOpacity(0.45),
                          fontSize: 16,
                          fontFamily: 'Questrial',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          top: 9.5,
                          bottom: 9.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 590,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 278,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF000000),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            "assets/hidden.png",
                            width: 25,
                            height: 25,
                          ),
                        ),
                        hintText: 'Confirm new password',
                        hintStyle: TextStyle(
                          color: const Color(0xFF081D5C).withOpacity(0.45),
                          fontSize: 16,
                          fontFamily: 'Questrial',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          top: 9.5,
                          bottom: 9.5,
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
    );
  }
}
