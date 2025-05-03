import 'package:flutter/material.dart';
import 'sign_in.dart'; // Import SignInScreen
import 'dart:async';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(color: Color(0xFFFFF6ED)),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: -50,
                      child: Container(
                        width: 390,
                        height: 955,
                        decoration: ShapeDecoration(
                          gradient: const RadialGradient(
                            center: Alignment(0.10, 0.37),
                            radius: 1.60,
                            colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(57),
                          ),
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 60,
                      top: 400,
                      child: SizedBox(
                        width: 277,
                        height: 30,
                        child: Text(
                          'The best digital flashcard app.',
                          style: TextStyle(
                            color: Color(0xFFD1E5FE),
                            fontSize: 20,
                            fontFamily: 'OPTIFrankfurter-Medium',
                            fontWeight: FontWeight.w400,
                            decoration:
                                TextDecoration.none, // <== Remove underline
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 35,
                      top: 250,
                      child: Container(
                        width: 320,
                        height: 125,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            fit: BoxFit.fill,
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
    );
  }
}
