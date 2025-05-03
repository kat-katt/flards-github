import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sign_in.dart';
import 'email_verify.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _errorMessage;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print(
        'Form validated, attempting sign-up with email: ${_emailController.text.trim()}',
      );
      try {
        // Create Firebase user
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        print('Firebase user created: ${userCredential.user!.uid}');

        // Store username in Firestore
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
                'username': _usernameController.text.trim(),
                'email': _emailController.text.trim(),
                'createdAt': FieldValue.serverTimestamp(),
                'timestamp': FieldValue.serverTimestamp(),
                'emailVerified': false, // Add emailVerified field
              });
          print('Firestore data saved for user: ${userCredential.user!.uid}');
        } catch (firestoreError) {
          print('Firestore error: $firestoreError');
          setState(() {
            _errorMessage = 'Failed to save user data';
          });
          return;
        }

        // Navigate to Email Verification page
        if (mounted) {
          print('Navigating to EmailVerificationForNewAcc');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const EmailVerificationForNewAcc(),
            ),
          );
        } else {
          print('Widget not mounted, skipping navigation');
        }
      } on FirebaseAuthException catch (e) {
        print('FirebaseAuth error: ${e.code}, message: ${e.message}');
        setState(() {
          _errorMessage = _getErrorMessage(e.code);
          print('Error message set: $_errorMessage');
        });
      } catch (e, stackTrace) {
        print('Unexpected error: $e');
        print('Error type: ${e.runtimeType}');
        print('Stack trace: $stackTrace');
        setState(() {
          _errorMessage = 'Sign-up failed: $e';
          print('Error message set: $_errorMessage');
        });
      }
    } else {
      print('Form validation failed');
      setState(() {
        _errorMessage = 'Please fill all fields correctly';
        print('Error message set: $_errorMessage');
      });
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Sign-up failed. Please try again.';
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Building SignUpPage, errorMessage: $_errorMessage');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SignUp(
            formKey: _formKey,
            usernameController: _usernameController,
            emailController: _emailController,
            passwordController: _passwordController,
            onSubmit: _submitForm,
            errorMessage: _errorMessage,
          ),
        ),
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;
  final String? errorMessage;

  const SignUp({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.onSubmit,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    print('Building SignUp widget, errorMessage: $errorMessage');
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            width: 390,
            height: MediaQuery.of(context).size.height,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFFFF6ED)),
            child: Stack(
              children: [
                const Positioned(
                  left: 0,
                  top: -52,
                  child: SizedBox(
                    width: 390,
                    height: 956,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        gradient: RadialGradient(
                          center: Alignment(0.10, 0.37),
                          radius: 1.60,
                          colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(57)),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -136.28,
                  top: 322.13,
                  child: Transform(
                    transform:
                        Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.29),
                    child: const SizedBox(
                      width: 187.42,
                      height: 588,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFF6ED),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 4,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(56)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -265,
                  top: 459.70,
                  child: Transform(
                    transform:
                        Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.29),
                    child: const SizedBox(
                      width: 194.05,
                      height: 588,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Color(0xFFD1E5FE),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 4,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(56)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -48.98,
                  top: 223.72,
                  child: Transform(
                    transform:
                        Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.17),
                    child: const SizedBox(
                      width: 365,
                      height: 588,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          color: Color(0xFFD1E5FE),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 4,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(56)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 28,
                  top: 180,
                  child: SizedBox(
                    width: 365,
                    height: 702,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 4,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(56)),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 64,
                  top: 209.27,
                  child: SizedBox(
                    width: 204,
                    height: 59,
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 40,
                        fontFamily: 'OPTIFrankfurter-Medium',
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 93,
                  top: 64,
                  child: SizedBox(
                    width: 213,
                    height: 84,
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const Positioned(
                  left: 72,
                  top: 279.27,
                  child: Text(
                    'Username',
                    style: TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                    ),
                  ),
                ),
                Positioned(
                  left: 76,
                  top: 309.27,
                  child: SizedBox(
                    width: 290,
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Image(
                            image: AssetImage("assets/acc.png"),
                            width: 15,
                            height: 15,
                          ),
                        ),
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 14,
                          fontFamily: 'OPTIFrankfurter-Medium',
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFD1E5FE),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.5),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const Positioned(
                  left: 72,
                  top: 375,
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                    ),
                  ),
                ),
                Positioned(
                  left: 76,
                  top: 400,
                  child: SizedBox(
                    width: 290,
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Image(
                            image: AssetImage("assets/acc.png"),
                            width: 15,
                            height: 15,
                          ),
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 14,
                          fontFamily: 'OPTIFrankfurter-Medium',
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFD1E5FE),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.5),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const Positioned(
                  left: 72,
                  top: 460,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                    ),
                  ),
                ),
                Positioned(
                  left: 76,
                  top: 485,
                  child: SizedBox(
                    width: 290,
                    child: TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 12, right: 12),
                          child: Image(
                            image: AssetImage("assets/lock.png"),
                            width: 19,
                            height: 19,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: Image(
                            image: AssetImage("assets/hidden.png"),
                            width: 22,
                            height: 16,
                          ),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 14,
                          fontFamily: 'OPTIFrankfurter-Medium',
                        ),
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Color(0xFFD1E5FE),
                        contentPadding: EdgeInsets.symmetric(vertical: 12.5),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const Positioned(
                  left: 60,
                  top: 545,
                  child: SizedBox(
                    width: 290,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'By signing up, you agree to our',
                            style: TextStyle(
                              color: Color(0xFF081D5C),
                              fontSize: 13,
                              fontFamily: 'OPTIFrankfurter-Medium',
                            ),
                          ),
                          TextSpan(
                            text: ' Terms & Conditions',
                            style: TextStyle(
                              color: Color(0xFF081D5C),
                              fontSize: 13,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: ' and ',
                            style: TextStyle(
                              color: Color(0xFF081D5C),
                              fontSize: 13,
                              fontFamily: 'OPTIFrankfurter-Medium',
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy.',
                            style: TextStyle(
                              color: Color(0xFF081D5C),
                              fontSize: 13,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (errorMessage != null)
                  Positioned(
                    left: 76,
                    top: 565,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontFamily: 'OPTIFrankfurter-Medium',
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: 80,
                  top: 595,
                  child: GestureDetector(
                    onTap: onSubmit,
                    child: const SizedBox(
                      width: 265,
                      height: 40,
                      child: DecoratedBox(
                        decoration: ShapeDecoration(
                          gradient: RadialGradient(
                            center: Alignment(1.23, -0.17),
                            radius: 5.88,
                            colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Create account',
                            style: TextStyle(
                              color: Color(0xFFFFF6ED),
                              fontSize: 24,
                              fontFamily: 'OPTIFrankfurter-Medium',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 128,
                  top: 645,
                  child: Text(
                    'Or create an account with',
                    style: TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                    ),
                  ),
                ),
                const Positioned(
                  left: 75,
                  top: 688.27,
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage("assets/facebook.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 171,
                  top: 688.27,
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage("assets/google.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 272,
                  top: 688.27,
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        color: Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 1.60,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage("assets/apple.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 87,
                  top: 784,
                  child: Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'OPTIFrankfurter-Medium',
                    ),
                  ),
                ),
                Positioned(
                  left: 258,
                  top: 784,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 14,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        decoration: TextDecoration.underline,
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
