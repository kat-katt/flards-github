import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({super.key});

  @override
  _ChangeUsernameState createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _usernameController.text =
        FirebaseAuth.instance.currentUser?.displayName ?? '';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _updateUsername() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a username')));
      return;
    }
    if (username.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username must be at least 3 characters')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(username);
      Navigator.pop(context); // Return to SettingsPage
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating username: $e')));
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 308,
        height: 288,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main container
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 308,
                height: 288,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFF6ED),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 7,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF081D5C),
                    ),
                    borderRadius: BorderRadius.circular(37),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            // Title: Change Username
            Positioned(
              left: 75,
              top: 41,
              child: SizedBox(
                width: 181,
                height: 27,
                child: Text(
                  'Change Username',
                  style: TextStyle(
                    color: const Color(0xFF081D5C),
                    fontSize: 20,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Label: Enter new username
            Positioned(
              left: 36,
              top: 104,
              child: Text(
                'Enter new username',
                style: TextStyle(
                  color: const Color(0xFF081D5C),
                  fontSize: 14,
                  fontFamily: 'Questrial',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Input field
            Positioned(
              left: 28,
              top: 126,
              child: Container(
                width: 245,
                height: 26,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD1E5FE),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF081D5C),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    hintText: 'Flardteam',
                    hintStyle: TextStyle(
                      color: const Color(0xFF081D5C).withOpacity(0.5),
                      fontSize: 16,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 16,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Save button
            Positioned(
              left: 88,
              top: 210,
              child: GestureDetector(
                onTap: _isLoading ? null : _updateUsername,
                child: Container(
                  width: 124,
                  height: 40,
                  decoration: ShapeDecoration(
                    gradient: const RadialGradient(
                      center: Alignment(1.23, -0.17),
                      radius: 5.88,
                      colors: [Color(0xFF646464), Color(0xFFA1A1A1)],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: Center(
                    child:
                        _isLoading
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Color(0xFFFFF6ED),
                                strokeWidth: 2,
                              ),
                            )
                            : Text(
                              'Save',
                              style: TextStyle(
                                color: const Color(0xFFFFF6ED),
                                fontSize: 24,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                  ),
                ),
              ),
            ),
            // Back button
            Positioned(
              left: 21,
              top: 14,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 47,
                  height: 41,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/back.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            // Logo
            Positioned(
              left: 32,
              top: 22,
              child: Container(
                width: 23,
                height: 19,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
