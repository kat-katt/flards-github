import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sign_in.dart'; // Import SignUpPage for navigation

class LogOutConfirmation extends StatelessWidget {
  const LogOutConfirmation({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logged out')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignIn()),
      );
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to log out')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 271,
          height: 304,
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: const Color(0xFFD1E5FE),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xFF081D5C)),
              borderRadius: BorderRadius.circular(19),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 49 - 16,
                top: 39 - 16,
                child: SizedBox(
                  width: 181,
                  height: 75,
                  child: Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(
                      color: const Color(0xFF081D5C),
                      fontSize: 24,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 34 - 16,
                top: 124 - 16,
                child: GestureDetector(
                  onTap: () => _handleLogout(context),
                  child: Container(
                    width: 211,
                    height: 53,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF344EAF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          color: const Color(0xFF081D5C),
                        ),
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 136,
                        height: 34,
                        child: Text(
                          'Log out',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFFFF6ED),
                            fontSize: 25,
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
                left: 34 - 16,
                top: 206 - 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
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
                    child: Center(
                      child: SizedBox(
                        width: 136,
                        height: 34,
                        child: Text(
                          'Cancel',
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
