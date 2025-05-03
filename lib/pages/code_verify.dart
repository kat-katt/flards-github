import 'package:flard/pages/forgot_pass.dart';
import 'package:flutter/material.dart';
import 'new_pass.dart';
import 'sign_in.dart';

class CodeVerify extends StatelessWidget {
  const CodeVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 390,
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
                left: -43,
                top: 320.50,
                child: Container(
                  transform:
                      Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-0.18),
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
                left: 26.70,
                top: 282,
                child: Container(
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
                    'Code \nverification',
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
                left: 53,
                top: 312,
                child: Container(
                  width: 47,
                  height: 41,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spades.png"),
                      fit: BoxFit.cover,
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
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
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
                left: 106,
                top: 477,
                child: SizedBox(
                  width: 203,
                  child: Text(
                    'Enter verification code',
                    style: TextStyle(
                      color: const Color(0xFF081D5C),
                      fontSize: 20,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 686,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewPassword()),
                    );
                  },
                  child: Stack(
                    children: [
                      Container(
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
                      Positioned(
                        left: 45,
                        top: 5,
                        child: SizedBox(
                          width: 156,
                          height: 30,
                          child: Text(
                            'Verify code',
                            style: TextStyle(
                              color: const Color(0xFFFFF6ED),
                              fontSize: 24,
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
              Positioned(
                left: 53,
                top: 513,
                child: Container(
                  width: 83,
                  height: 83,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spades.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 127,
                top: 513,
                child: Container(
                  width: 83,
                  height: 83,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spades.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 202,
                top: 513,
                child: Container(
                  width: 83,
                  height: 83,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spades.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 276,
                top: 511,
                child: Container(
                  width: 83,
                  height: 83,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/spades.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 616,
                child: SizedBox(
                  width: 288,
                  child: Text(
                    'Didn’t receive the code? ',
                    style: TextStyle(
                      color: const Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 77,
                top: 525,
                child: SizedBox(
                  width: 32,
                  child: Opacity(
                    opacity: 0.45,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 36,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 153,
                top: 525,
                child: SizedBox(
                  width: 32,
                  child: Opacity(
                    opacity: 0.45,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 36,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 228,
                top: 525,
                child: SizedBox(
                  width: 32,
                  child: Opacity(
                    opacity: 0.45,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 36,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 300,
                top: 525,
                child: SizedBox(
                  width: 32,
                  child: Opacity(
                    opacity: 0.45,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 36,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 255,
                top: 617.5,
                child: SizedBox(
                  width: 288,
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      color: const Color(0xFF081D5C),
                      fontSize: 13,
                      fontFamily: 'OPTIFrankfurter-Medium',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.underline,
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
