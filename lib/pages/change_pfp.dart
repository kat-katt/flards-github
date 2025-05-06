import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeProfile extends StatelessWidget {
  final Function(String) onProfilePictureChanged;

  const ChangeProfile({super.key, required this.onProfilePictureChanged});

  Future<void> _selectProfilePicture(
    BuildContext context,
    String pfpPath,
  ) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'profilePicture': pfpPath,
        }, SetOptions(merge: true));
        onProfilePictureChanged(pfpPath);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile picture updated')),
        );
      }
    } catch (e) {
      print('Error updating profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile picture')),
      );
    }
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
                  left: -10,
                  top: -89,
                  child: Container(
                    width: 464,
                    height: 1354,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.10, 0.37),
                        radius: 1.60,
                        colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 115,
                  child: Container(
                    width: 360,
                    height: 648,
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
                  left: 15,
                  top: 118,
                  child: SizedBox(
                    width: 360,
                    height: 607,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 86,
                          top: 102,
                          child: Container(
                            width: 188,
                            height: 168,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/profile.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 28,
                          top: 32,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 47,
                              height: 41,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/spade_back.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 58,
                          top: 276,
                          child: Container(
                            width: 245,
                            height: 242,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFF6ED),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                  color: const Color(0xFF081D5C),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: GridView.count(
                              crossAxisCount: 3,
                              padding: const EdgeInsets.all(8),
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              children: [
                                for (int i = 1; i <= 9; i++)
                                  GestureDetector(
                                    onTap:
                                        () => _selectProfilePicture(
                                          context,
                                          'assets/pfp$i.png',
                                        ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('assets/pfp$i.png'),
                                          fit: BoxFit.contain,
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
                ),
                Positioned(
                  left: 97,
                  top: 705,
                  child: GestureDetector(
                    onTap:
                        () => _selectProfilePicture(
                          context,
                          'assets/profile.png',
                        ),
                    child: Container(
                      width: 197,
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
                        child: Text(
                          'Change Photo',
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
                Positioned(
                  left: 135,
                  top: 54,
                  child: Container(
                    width: 111,
                    height: 44,
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
    );
  }
}
