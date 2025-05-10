import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';
import 'change_bio.dart';
import 'change_pfp.dart';
import 'logout_prompt.dart';
import 'create_flashcard_set_page.dart';
import 'newfolder.dart';
import 'item.dart';
import 'folders.dart';
import 'flashcard_set_preview_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 2;
  String _bio = 'Add a bio...';
  String _profilePicture = 'assets/profile.png';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<Item>> _foldersFuture;
  late Future<List<Item>> _setsFuture;

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
    _loadFolders();
    _loadSets();
  }

  Future<void> _loadProfilePicture() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to log out')),
      );
    }
  }

  Future<List<Item>> fetchFolders() async {
    final user = _auth.currentUser;
    if (user == null) return [];
    print("Fetching folders for UID: ${user.uid}");

    final querySnapshot = await _firestore
        .collection('folders')
        .where('user_id', isEqualTo: user.uid)
        .get();
    return querySnapshot.docs.map((doc) => Item.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<Item>> fetchSets() async {
    final user = _auth.currentUser;
    if (user == null) return [];
    print("Fetching sets for UID: ${user.uid}");

    final querySnapshot = await _firestore
        .collection('sets')
        .where('user_id', isEqualTo: user.uid)
        .get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Add the document ID to the data
      return Item.fromMap(data);
    }).toList();
  }

  Future<void> _loadFolders() async {
    setState(() {
      _foldersFuture = fetchFolders();
    });
  }

  Future<void> _loadSets() async {
    setState(() {
      _setsFuture = fetchSets();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      ).then((_) {
        // Refresh when returning to HomePage if needed
      });
    } else if (index == 1) {
      _showCreateDialog();
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
      builder: (context) => const Dialog(
        backgroundColor: Colors.transparent,
        child: LogOutConfirmation(),
      ),
    );
  }

  void _goToChangeProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeProfile(
          onProfilePictureChanged: (newProfilePicture) {
            _updateProfilePicture(newProfilePicture);
          },
        ),
      ),
    );
  }

  void _showCreateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFD1E5FE),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF081D5C), width: 2),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://placehold.co/45x45"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 23,
                            height: 19,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://placehold.co/23x19"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 40,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        final result = await showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          pageBuilder: (context, _, __) => CreateFlashcardSetPage(),
                          transitionBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        );
                        if (result != null && mounted) {
                          _loadSets(); // Refresh sets after creation
                        }
                      },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: 37,
                              height: 37,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://placehold.co/37x37"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'New set',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 25,
                                    fontFamily: 'OPTIFrankfurter-Medium',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        final result = await showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          pageBuilder: (context, _, __) => const NewFolder(),
                          transitionBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        );
                        if (result != null && result is Item && mounted) {
                          _loadFolders();
                        }
                      },
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://placehold.co/33x33"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'New folder',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 25,
                                    fontFamily: 'OPTIFrankfurter-Medium',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF081D5C),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
                          child: FutureBuilder<List<Item>>(
                            future: _setsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              final sets = snapshot.data ?? [];
                              if (sets.isEmpty) {
                                return Container(
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
                                );
                              }
                              return SizedBox(
                                width: 312,
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sets.length,
                                  itemBuilder: (context, index) {
                                    final set = sets[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FlashcardSetPreviewPage(setId: set.id),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Image.asset(
                                                "assets/folder.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                set.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF081D5C),
                                                  fontSize: 14,
                                                  fontFamily: 'Questrial',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
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
                          child: FutureBuilder<List<Item>>(
                            future: _foldersFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              final folders = snapshot.data ?? [];
                              if (folders.isEmpty) {
                                return Container(
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
                                );
                              }
                              return SizedBox(
                                width: 312,
                                height: 150,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: folders.length,
                                  itemBuilder: (context, index) {
                                    final folder = folders[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Folders(folder: folder),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.folder,
                                              color: Color(0xFF081D5C),
                                              size: 40,
                                            ),
                                            SizedBox(height: 8),
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                folder.name,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFF081D5C),
                                                  fontSize: 14,
                                                  fontFamily: 'Questrial',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
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
                  color: _selectedIndex == 0 ? const Color(0xFFE0E0E0) : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _selectedIndex == 0
                      ? [
                    const BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ]
                      : [],
                ),
                child: const Icon(Icons.home, size: 30),
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
                  color: _selectedIndex == 1 ? const Color(0xFFE0E0E0) : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _selectedIndex == 1
                      ? [
                    const BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ]
                      : [],
                ),
                child: const Icon(Icons.add_circle_outline, size: 30),
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
                  color: _selectedIndex == 2 ? const Color(0xFFE0E0E0) : const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: _selectedIndex == 2
                      ? [
                    const BoxShadow(
                      color: Colors.blue,
                      blurRadius: 10,
                      spreadRadius: 3,
                    ),
                  ]
                      : [],
                ),
                child: const Icon(Icons.person, size: 30),
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
