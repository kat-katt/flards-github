import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'flashcard_settings_page.dart' as flashcard;

class FlashcardSetPreviewPage extends StatefulWidget {
  final String setId;

  const FlashcardSetPreviewPage({super.key, required this.setId});

  @override
  _FlashcardSetPreviewPageState createState() =>
      _FlashcardSetPreviewPageState();
}

class _FlashcardSetPreviewPageState extends State<FlashcardSetPreviewPage> {
  final _pageController = PageController(viewportFraction: 0.8);
  var _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD1E5FE),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('sets')
                .doc(widget.setId)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Set not found'));
          }

          final setData = snapshot.data!.data() as Map<String, dynamic>;
          final String title = setData['title'] ?? 'Untitled';
          final List<dynamic> cards = setData['cards'] ?? [];
          final String username =
              FirebaseAuth.instance.currentUser?.displayName ?? 'parabeenFree';

          return Stack(
            children: [
              // Back button
              Positioned(
                left: 46,
                top: 77,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icons/back.png',
                    width: 45,
                    height: 45,
                  ),
                ),
              ),
              // Logo
              Positioned(
                left: 135,
                top: 74,
                child: Image.asset(
                  'assets/icons/logo.png',
                  width: 111,
                  height: 44,
                ),
              ),
              // Settings button
              Positioned(
                left: 304,
                top: 77,
                child: GestureDetector(
                  onTap: () async {
                    final result = await showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: 'Dismiss',
                      pageBuilder:
                          (context, _, __) =>
                              flashcard.SetOptions(setId: widget.setId),
                    );
                    if (result != null &&
                        (result as Map<String, dynamic>)['deleted'] == true) {
                      Navigator.pop(context); // Return to previous page
                    }
                  },
                  child: Image.asset(
                    'assets/icons/settings.png',
                    width: 49,
                    height: 45,
                  ),
                ),
              ),
              // Flashcard preview (PageView)
              Positioned(
                left: 0,
                right: 0,
                top: 176,
                child: SizedBox(
                  height: 310,
                  child: PageView.builder(
                    controller: _pageController,
                    clipBehavior: Clip.hardEdge,
                    physics: const ClampingScrollPhysics(),
                    itemCount: cards.length,
                    onPageChanged: (index) {
                      print('Page changed to: $index');
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 185.59,
                            maxHeight: 289.93,
                            minWidth: 185.59,
                            minHeight: 289.93,
                          ),
                          child: Container(
                            width: 185.59,
                            height: 289.93,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFF6ED),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 5,
                                  color: Color(0xFF081D5C),
                                ),
                                borderRadius: BorderRadius.circular(18),
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
                            child: Stack(
                              children: [
                                // Definition
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: SizedBox(
                                      width: 145,
                                      height: 170,
                                      child: Text(
                                        card['definition'] ?? 'No definition',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF081D5C),
                                          fontSize: 20,
                                          fontFamily: 'Questrial',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Top-left "F"
                                Positioned(
                                  left: 7,
                                  top: 11,
                                  child: SizedBox(
                                    width: 38,
                                    height: 26,
                                    child: Text(
                                      'F',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Color(0xFF081D5C),
                                        fontSize: 20,
                                        fontFamily: 'OPTIFrankfurter-Medium',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                // Top-left spade
                                Positioned(
                                  left: 16,
                                  top: 35,
                                  child: Image.asset(
                                    'assets/icons/flardspade.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                // Bottom-right "F" (rotated)
                                Positioned(
                                  left: 140,
                                  top: 253,
                                  child: Transform.rotate(
                                    angle: 3.14159,
                                    child: SizedBox(
                                      width: 38,
                                      height: 26,
                                      child: Text(
                                        'F',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color(0xFF081D5C),
                                          fontSize: 20,
                                          fontFamily: 'OPTIFrankfurter-Medium',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // Bottom-right spade (rotated)
                                Positioned(
                                  left: 149,
                                  top: 229,
                                  child: Transform.rotate(
                                    angle: 3.14159,
                                    child: Image.asset(
                                      'assets/icons/flardspade.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Carousel indicator
              Positioned(
                left: 0,
                right: 0,
                top: 466,
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: cards.length,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Color(0xFFFFFFFF),
                      dotColor: Color(0xFF6F96D1),
                      expansionFactor: 3,
                    ),
                  ),
                ),
              ),
              // Set title
              Positioned(
                left: 67,
                top: 544,
                child: SizedBox(
                  width: 293,
                  height: 111,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 32,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                          height: 1.20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Current Page: ${_currentPage + 1}',
                        style: const TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 16,
                          fontFamily: 'Questrial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Terms icon
              Positioned(
                left: 57,
                top: 627.80,
                child: Image.asset(
                  'assets/icons/terms.png',
                  width: 41.40,
                  height: 25.48,
                ),
              ),
              // Term count
              Positioned(
                left: 88.59,
                top: 634.17,
                child: SizedBox(
                  width: 69.72,
                  height: 15.29,
                  child: Text(
                    '${cards.length} terms',
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // User icon
              Positioned(
                left: 157.23,
                top: 631.62,
                child: Image.asset(
                  'assets/icons/user.png',
                  width: 22.40,
                  height: 20.38,
                ),
              ),
              // Username
              Positioned(
                left: 178.31,
                top: 634.17,
                child: SizedBox(
                  width: 110.69,
                  height: 24.20,
                  child: Text(
                    'by $username',
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 14,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Share button
              Positioned(
                left: 300,
                top: 625,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Share feature coming soon!'),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/share.png',
                    width: 23,
                    height: 23,
                  ),
                ),
              ),
              // Study Set button
              Positioned(
                left: 113,
                top: 696,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Study feature coming soon!'),
                      ),
                    );
                  },
                  child: Container(
                    width: 164,
                    height: 40,
                    decoration: ShapeDecoration(
                      gradient: const RadialGradient(
                        center: Alignment(2.27, -6.55),
                        radius: 13.30,
                        colors: [Color(0xFF344EAF), Color(0xFF081D5C)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Study set',
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
            ],
          );
        },
      ),
    );
  }
}
