import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_pass.dart';
import 'home.dart';
import 'signup.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;
  bool _rememberMe = false;

  Future<void> _signIn() async {
    try {
      print('Attempting sign-in with email: ${_emailController.text.trim()}');
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print('Sign-in successful');
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth error: ${e.code}, message: ${e.message}');
      setState(() {
        _errorMessage = _getErrorMessage(e.code);
      });
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print('Stack trace: $stackTrace');
      setState(() {
        _errorMessage = 'Sign-in failed: Check your connection or try again.';
      });
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      default:
        return 'Sign-in failed. Please try again.';
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 390,
              height: MediaQuery.of(context).size.height,
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
                  const Positioned(
                    left: 66,
                    top: 217,
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
                    left: -40.98,
                    top: 317.45,
                    child: Container(
                      transform:
                          Matrix4.identity()
                            ..translate(0.0, 0.0)
                            ..rotateZ(-0.17),
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
                    left: 36,
                    top: 274,
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
                  const Positioned(
                    left: 72,
                    top: 303,
                    child: SizedBox(
                      width: 204,
                      height: 59,
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 40,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 121,
                    top: 790,
                    child: Text(
                      'Don’t have an account? ',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 14,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 275,
                    top: 790,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 14,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 273,
                    top: 530,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 12,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 73,
                    child: Container(
                      width: 319,
                      height: 126,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/logo.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 72,
                    top: 373,
                    child: Text(
                      'Email address or username',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 14,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 76,
                    top: 403,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 290,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1E5FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _emailController,
                          style: const TextStyle(
                            color: Color(0xFF081D5C),
                            fontSize: 16,
                            fontFamily: 'OPTIFrankfurter-Medium',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: Image(
                                image: AssetImage("assets/acc.png"),
                                width: 15,
                                height: 15,
                              ),
                            ),
                            hintText: 'Enter your email or username',
                            hintStyle: TextStyle(
                              color: Color.fromRGBO(8, 29, 92, 0.45),
                              fontSize: 14,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 72,
                    top: 457,
                    child: Text(
                      'Password',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 14,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 76,
                    top: 488,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 290,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1E5FE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(
                            color: Color(0xFF081D5C),
                            fontSize: 16,
                            fontFamily: 'OPTIFrankfurter-Medium',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 12, right: 12),
                              child: Image(
                                image: AssetImage("assets/lock.png"),
                                width: 19,
                                height: 19,
                              ),
                            ),
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: Image(
                                image: AssetImage("assets/hidden.png"),
                                width: 22,
                                height: 16,
                              ),
                            ),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                              color: const Color(0xFF081D5C).withOpacity(0.45),
                              fontSize: 14,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 98,
                    top: 535,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                      child: const Text(
                        'Remember me',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 12,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 78,
                    top: 533,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _rememberMe = !_rememberMe;
                        });
                      },
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: ShapeDecoration(
                          color:
                              _rememberMe
                                  ? const Color(0xFF081D5C)
                                  : const Color(0xFFFFF6ED),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 1,
                              color: Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child:
                            _rememberMe
                                ? const Icon(
                                  Icons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                                : null,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 109,
                    top: 574,
                    child: GestureDetector(
                      onTap: _signIn,
                      child: Stack(
                        children: [
                          Container(
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
                          ),
                          const Positioned(
                            left: 65,
                            top: 5,
                            child: SizedBox(
                              width: 156,
                              height: 30,
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  color: Color(0xFFFFF6ED),
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
                  if (_errorMessage != null)
                    Positioned(
                      left: 77,
                      top: 620,
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  const Positioned(
                    left: 164,
                    top: 647,
                    child: Text(
                      'Or continue with',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 14,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 88,
                    top: 695,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 98,
                    top: 706,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/apple.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 184,
                    top: 695,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 194,
                    top: 706,
                    child: Container(
                      width: 47,
                      height: 47,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/google.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 285,
                    top: 695,
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 298,
                    top: 708,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/facebook.png"),
                          fit: BoxFit.cover,
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
    );
  }
}
