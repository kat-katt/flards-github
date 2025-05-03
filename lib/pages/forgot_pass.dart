import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'code_verify.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
                      fontFamily: 'OPTIFrankfurter-Medium',
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
                    'Forgot \npassword',
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
                      MaterialPageRoute(builder: (context) => SignIn()),
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
                left: 69,
                top: 474,
                child: SizedBox(
                  width: 288,
                  child: Text(
                    'Enter the email address you signed up with. We\'ll email you a verification code to log in and reset your password.',
                    style: TextStyle(
                      color: const Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 68,
                top: 541,
                child: Text(
                  'Email address ',
                  style: TextStyle(
                    color: const Color(0xFF081D5C),
                    fontSize: 14,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Positioned(
                left: 72,
                top: 570,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 278,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF081D5C),
                        width: 1,
                      ),
                    ),
                    child: TextField(
                      style: TextStyle(
                        color: const Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Image.asset(
                            "assets/acc.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        hintText: 'Enter recovery email',
                        hintStyle: TextStyle(
                          color: const Color(0xFF081D5C).withOpacity(0.45),
                          fontSize: 16,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 9.5),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 100,
                top: 635,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CodeVerify()),
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
                        left: 47,
                        top: 4,
                        child: SizedBox(
                          width: 125,
                          height: 30,
                          child: Text(
                            'Send code',
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
            ],
          ),
        ),
      ],
    );
  }
}
