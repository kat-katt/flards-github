import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'newfolder.dart';
import 'create_flashcard_set_page.dart';
import 'folders.dart';
import 'item.dart';
import 'profile.dart';
import 'flashcard_set_preview_page.dart'; // Add this import for set navigation

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      _showCreateDialog();
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profile()),
      );
    }
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
                      onTap: () {
                        Navigator.pop(context);
                        showGeneralDialog(
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
                        // No need to update local folders list; Firestore handles it
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
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Please log in')),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 390,
              height: 1203,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://placehold.co/390x1203"),
                  fit: BoxFit.contain,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: -10,
                    top: -89,
                    child: Container(
                      width: 464,
                      height: 1354,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          center: const Alignment(0.10, 0.37),
                          radius: 1.60,
                          colors: [
                            const Color(0xFF344EAF),
                            const Color(0xFF6F96D1),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 14,
                    top: 17,
                    child: SizedBox(
                      width: 360,
                      height: 1208,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 175,
                            child: Container(
                              width: 360,
                              height: 1348,
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
                            left: 39,
                            top: 98,
                            child: Container(
                              width: 316,
                              height: 53,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFF6ED),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 97,
                            top: 118,
                            child: SizedBox(
                              width: 153,
                              height: 17,
                              child: Text(
                                'Sets, tags, users',
                                style: TextStyle(
                                  color: const Color(0xFF354FAF),
                                  fontSize: 16,
                                  fontFamily: 'Questrial',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 54,
                            top: 114,
                            child: Icon(
                              Icons.search,
                              size: 27,
                              color: const Color(0xFF354FAF),
                            ),
                          ),
                          Positioned(
                            left: 30,
                            top: 42,
                            child: Container(
                              width: 111,
                              height: 44,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/logo.png"),
                                  fit: BoxFit.fill,
                                ),
                                boxShadow: [
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
                          Positioned(
                            left: 24,
                            top: 215,
                            child: SizedBox(
                              width: 320,
                              height: 27,
                              child: Text(
                                'Recently opened sets',
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
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return const Center(child: Text('Error loading sets'));
                                }
                                if (!snapshot.hasData || snapshot.data!.data() == null) {
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

                                final data = snapshot.data!.data() as Map<String, dynamic>;
                                final recentSets = List<Map<String, dynamic>>.from(data['recentSets'] ?? []);
                                if (recentSets.isEmpty) {
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

                                recentSets.sort((a, b) => DateTime.parse(b['lastOpened']).compareTo(DateTime.parse(a['lastOpened'])));
                                return SizedBox(
                                  width: 312,
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: recentSets.length,
                                    itemBuilder: (context, index) {
                                      final set = recentSets[index];
                                      return FutureBuilder<DocumentSnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('sets')
                                            .doc(set['setId'])
                                            .get(),
                                        builder: (context, setSnapshot) {
                                          if (!setSnapshot.hasData || !setSnapshot.data!.exists) {
                                            return const SizedBox.shrink();
                                          }
                                          final setData = setSnapshot.data!.data() as Map<String, dynamic>;
                                          return Padding(
                                            padding: const EdgeInsets.only(right: 24),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => FlashcardSetPreviewPage(setId: set['setId']),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 150,
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
                                                    const SizedBox(height: 8),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                                      child: Text(
                                                        setData['title'] ?? 'Untitled Set',
                                                        style: const TextStyle(
                                                          color: Color(0xFF081D5C),
                                                          fontSize: 16,
                                                          fontFamily: 'Questrial',
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
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
                                'Recently opened folders',
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
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return const Center(child: Text('Error loading folders'));
                                }
                                if (!snapshot.hasData || snapshot.data!.data() == null) {
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

                                final data = snapshot.data!.data() as Map<String, dynamic>;
                                final recentFolders = List<Map<String, dynamic>>.from(data['recentFolders'] ?? []);
                                if (recentFolders.isEmpty) {
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

                                recentFolders.sort((a, b) => DateTime.parse(b['lastOpened']).compareTo(DateTime.parse(a['lastOpened'])));
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    width: 312,
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: recentFolders.length,
                                      itemBuilder: (context, index) {
                                        final folder = recentFolders[index];
                                        return FutureBuilder<DocumentSnapshot>(
                                          future: FirebaseFirestore.instance
                                              .collection('folders')
                                              .doc(folder['folderId'])
                                              .get(),
                                          builder: (context, folderSnapshot) {
                                            if (!folderSnapshot.hasData || !folderSnapshot.data!.exists) {
                                              return const SizedBox.shrink();
                                            }
                                            final folderData = folderSnapshot.data!.data() as Map<String, dynamic>;
                                            return Padding(
                                              padding: const EdgeInsets.only(right: 24),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => Folders(
                                                        folder: Item(
                                                          id: folder['folderId'],
                                                          name: folderData['name'] ?? 'Untitled Folder',
                                                          userId: folderData['userId'] ?? '',
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: 150,
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
                                                          "assets/folderr.png",
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                                        child: Text(
                                                          folderData['name'] ?? 'Untitled Folder',
                                                          style: const TextStyle(
                                                            color: Color(0xFF081D5C),
                                                            fontSize: 16,
                                                            fontFamily: 'Questrial',
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
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
