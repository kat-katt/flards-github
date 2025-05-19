import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'sign_in.dart';

class EmailVerificationForNewAcc extends StatefulWidget {
  const EmailVerificationForNewAcc({super.key});

  @override
  _EmailVerificationForNewAccState createState() =>
      _EmailVerificationForNewAccState();
}

class _EmailVerificationForNewAccState
    extends State<EmailVerificationForNewAcc> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<TextEditingController> _codeControllers = List.generate(
    4,
        (_) => TextEditingController(),
  );
  String? _generatedCode;
  String? _errorMessage;
  int _activeIndex = -1; // Track which spade is active for input
  final TextEditingController _hiddenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _sendVerificationCode();
  }

  Future<void> _sendVerificationCode() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Generate a random 4-digit code
        _generatedCode = (Random().nextInt(9000) + 1000).toString();
        print('Generated code: $_generatedCode'); // For debugging

        // Store the code in Firestore temporarily
        await _firestore.collection('verification_codes').doc(user.uid).set({
          'code': _generatedCode,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // In a real app, you'd send this code via email using a service like Firebase Cloud Functions
        // For this example, we'll assume the code is sent and log it for testing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Verification code sent: $_generatedCode')),
        );
      }
    } catch (e) {
      print('Error sending verification code: $e');
      setState(() {
        _errorMessage = 'Failed to send verification code';
      });
    }
  }

  Future<void> _resendVerificationCode() async {
    setState(() {
      _errorMessage = null;
      for (var controller in _codeControllers) {
        controller.clear();
      }
      _activeIndex = -1;
    });
    await _sendVerificationCode();
  }

  Future<void> _verifyCode() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        setState(() {
          _errorMessage = 'User not found';
        });
        return;
      }

      String enteredCode =
      _codeControllers.map((controller) => controller.text).join();
      if (enteredCode.length != 4) {
        setState(() {
          _errorMessage = 'Please enter a 4-digit code';
        });
        return;
      }

      DocumentSnapshot doc =
      await _firestore.collection('verification_codes').doc(user.uid).get();
      if (!doc.exists || doc['code'] != enteredCode) {
        setState(() {
          _errorMessage = 'Invalid verification code';
        });
        return;
      }

      // Code is correct, mark email as verified
      await user.reload();
      await _firestore.collection('users').doc(user.uid).update({
        'emailVerified': true,
      });

      // Clean up the verification code
      await _firestore.collection('verification_codes').doc(user.uid).delete();

      // Navigate to SignIn page
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      }
    } catch (e) {
      print('Error verifying code: $e');
      setState(() {
        _errorMessage = 'Verification failed';
      });
    }
  }

  void _handleTap(int index) {
    setState(() {
      _activeIndex = index;
    });
    _hiddenController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Digit'),
        content: TextField(
          controller: _hiddenController,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(hintText: 'Enter a digit (0-9)'),
          onChanged: (value) {
            if (value.length == 1 && int.tryParse(value) != null) {
              _codeControllers[_activeIndex].text = value;
              Navigator.pop(context);
              setState(() {
                _activeIndex = -1;
                if (_activeIndex < 3) _activeIndex++;
              });
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    _hiddenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 390,
            height: 844,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFFFF6ED)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: -52,
                  child: Container(
                    width: 390,
                    height: 956,
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
                        side: const BorderSide(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF081D5C),
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
                        side: const BorderSide(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF081D5C),
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
                        side: const BorderSide(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF081D5C),
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
                        side: const BorderSide(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF081D5C),
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
                        side: const BorderSide(
                          width: 4,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF081D5C),
                        ),
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 80,
                  child: Container(
                    width: 319,
                    height: 126,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("assets/logo.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 65,
                  top: 369,
                  child: SizedBox(
                    width: 134,
                    child: Text(
                      'Email',
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
                  left: 65,
                  top: 410,
                  child: SizedBox(
                    width: 278,
                    child: Text(
                      'verification',
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
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 47,
                      height: 41,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/arrow back.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 66,
                  top: 485,
                  child: SizedBox(
                    width: 294,
                    child: Text(
                      'Enter the verification code sent to your email',
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
                  top: 706,
                  child: GestureDetector(
                    onTap: _verifyCode,
                    child: Container(
                      width: 216,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: const RadialGradient(
                          center: Alignment(1.23, -0.17),
                          radius: 5.88,
                          colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: const Center(
                        child: SizedBox(
                          width: 156,
                          height: 30,
                          child: Text(
                            'Verify email',
                            style: TextStyle(
                              color: Color(0xFFFFF6ED),
                              fontSize: 24,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 53,
                  top: 556,
                  child: GestureDetector(
                    onTap: () => _handleTap(0),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/spades.png",
                          width: 83,
                          height: 83,
                        ),
                        if (_codeControllers[0].text.isNotEmpty)
                          Center(
                            child: Text(
                              _codeControllers[0].text,
                              style: const TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 36,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 127,
                  top: 556,
                  child: GestureDetector(
                    onTap: () => _handleTap(1),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/spades.png",
                          width: 83,
                          height: 83,
                        ),
                        if (_codeControllers[1].text.isNotEmpty)
                          Center(
                            child: Text(
                              _codeControllers[1].text,
                              style: const TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 36,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 202,
                  top: 556,
                  child: GestureDetector(
                    onTap: () => _handleTap(2),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/spades.png",
                          width: 83,
                          height: 83,
                        ),
                        if (_codeControllers[2].text.isNotEmpty)
                          Center(
                            child: Text(
                              _codeControllers[2].text,
                              style: const TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 36,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 276,
                  top: 554,
                  child: GestureDetector(
                    onTap: () => _handleTap(3),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/spades.png",
                          width: 83,
                          height: 83,
                        ),
                        if (_codeControllers[3].text.isNotEmpty)
                          Center(
                            child: Text(
                              _codeControllers[3].text,
                              style: const TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 36,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 659,
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
                  left: 255,
                  top: 658,
                  child: GestureDetector(
                    onTap: _resendVerificationCode,
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
                ),
                if (_errorMessage != null)
                  Positioned(
                    left: 53,
                    top: 638,
                    child: SizedBox(
                      width: 294,
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'Questrial',
                          fontWeight: FontWeight.w400,
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