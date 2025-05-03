import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'change_bio.dart';
import 'change_pfp.dart';
import 'logout_prompt.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 2;
  String _bio = 'Add a bio...';
  String _profilePicture = 'assets/profile.png'; // Default profile picture
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc['profilePicture'] != null) {
          setState(() {
            _profilePicture = userDoc['profilePicture'];
          });
        }
      }
    } catch (e) {
      print('Error loading profile picture: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load profile picture')),
      );
    }
  }

  Future<void> _updateProfilePicture(String newProfilePicture) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'profilePicture': newProfilePicture,
        }, SetOptions(merge: true));
        setState(() {
          _profilePicture = newProfilePicture;
        });
      }
    } catch (e) {
      print('Error updating profile picture: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Failed to log out')));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  void _updateBio(String newBio) {
    setState(() {
      _bio = newBio.isEmpty ? 'Add a bio...' : newBio;
    });
  }

  void _showChangeBioDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ChangeBio(onSave: _updateBio),
        );
      },
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder:
          (context) => const Dialog(
            backgroundColor: Colors.transparent,
            child: LogOutConfirmation(),
          ),
    );
  }

  void _goToChangeProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ChangeProfile(
              onProfilePictureChanged: (newProfilePicture) {
                _updateProfilePicture(newProfilePicture);
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                  left: 120,
                  top: 42,
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
                Positioned(
                  left: 15,
                  top: 110,
                  child: SizedBox(
                    width: 360,
                    height: 734,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 360,
                            height: 734,
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
                          left: 132,
                          top: 48,
                          child: Container(
                            width: 96,
                            height: 96,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage(_profilePicture),
                                fit: BoxFit.fill,
                              ),
                              shape: OvalBorder(
                                side: BorderSide(
                                  width: 2,
                                  color: Color(0xFF081D5C),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 208,
                          top: 116,
                          child: GestureDetector(
                            onTap: _goToChangeProfile,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/change pfp.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 150,
                          child: SizedBox(
                            width: 320,
                            height: 20,
                            child: Text(
                              '@username',
                              style: TextStyle(
                                color: const Color(0xFF081D5C),
                                fontSize: 16,
                                fontFamily: 'Questrial',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 170,
                          child: SizedBox(
                            width: 320,
                            height: 17,
                            child: Text(
                              _bio,
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
                          left: 330,
                          top: 170,
                          child: GestureDetector(
                            onTap: _showChangeBioDialog,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/edit.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 24,
                          top: 24,
                          child: GestureDetector(
                            onTap: _logout,
                            child: Container(
                              width: 31,
                              height: 31,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/logout.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 215,
                          child: SizedBox(
                            width: 320,
                            height: 27,
                            child: Text(
                              'Your Sets',
                              style: TextStyle(
                                color: const Color(0xFF081D5C),
                                fontSize: 20,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 270,
                          child: Container(
                            width: 312,
                            height: 150,
                            decoration: ShapeDecoration(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                    "assets/folder.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No Sets Yet!',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 18,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tap Create to Get Started!',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 14,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 450,
                          child: SizedBox(
                            width: 320,
                            height: 27,
                            child: Text(
                              'Your Folders',
                              style: TextStyle(
                                color: const Color(0xFF081D5C),
                                fontSize: 20,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          top: 500,
                          child: Container(
                            width: 312,
                            height: 150,
                            decoration: ShapeDecoration(
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                    "assets/folder.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'No Folders Yet!',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 18,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Tap Create to Get Started!',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 14,
                                    fontFamily: 'Questrial',
                                    fontWeight: FontWeight.w400,
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(0),
              child: AnimatedContainer(
                padding: const EdgeInsets.all(8),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 0
                          ? const Color(0xFFE0E0E0)
                          : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:
                      _selectedIndex == 0
                          ? [
                            const BoxShadow(
                              color: Color(0xFF354FAF),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ]
                          : [],
                ),
                child: Image.asset("assets/home.png", width: 30, height: 30),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(1),
              child: AnimatedContainer(
                padding: const EdgeInsets.all(8),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 1
                          ? const Color(0xFFE0E0E0)
                          : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:
                      _selectedIndex == 1
                          ? [
                            const BoxShadow(
                              color: Color(0xFF354FAF),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ]
                          : [],
                ),
                child: Image.asset("assets/create.png", width: 30, height: 30),
              ),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () => _onItemTapped(2),
              child: AnimatedContainer(
                padding: const EdgeInsets.all(8),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color:
                      _selectedIndex == 2
                          ? const Color(0xFFE0E0E0)
                          : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow:
                      _selectedIndex == 2
                          ? [
                            const BoxShadow(
                              color: Color(0xFF354FAF),
                              blurRadius: 10,
                              spreadRadius: 3,
                            ),
                          ]
                          : [],
                ),
                child: Image.asset(
                  "assets/profile_icon.png",
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color(0xFF081D5C),
        unselectedItemColor: const Color(0xFF081D5C),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'OPTIFrankfurter-Medium',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'OPTIFrankfurter-Medium',
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
