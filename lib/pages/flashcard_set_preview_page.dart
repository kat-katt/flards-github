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
  late PageController _pageController;
  int _currentPage = 0;
  List<dynamic> _cards = []; // Cache cards to prevent rebuild issues
  String _title = 'Untitled';
  String _username = 'parabeenFree';

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Color(0xFFFFF6ED)),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
              left: -22,
              top: -33,
              child: Container(
                width: MediaQuery.of(context).size.width + 10,
                height: MediaQuery.of(context).size.height + 66,
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
            StreamBuilder<DocumentSnapshot>(
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
                _title = setData['title'] ?? 'Untitled';
                _cards = setData['cards'] ?? [];
                _username =
                    FirebaseAuth.instance.currentUser?.displayName ??
                    'parabeenFree';

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
                        'assets/logo.png',
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
                              (result as Map<String, dynamic>)['deleted'] ==
                                  true) {
                            Navigator.pop(context);
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
                      left: 91,
                      top: 176,
                      child: SizedBox(
                        width: 230,
                        height: 350,
                        child: PageView.builder(
                          key: ValueKey(
                            _cards.length,
                          ), // Prevent rebuild issues
                          controller: _pageController,
                          clipBehavior: Clip.none,
                          physics:
                              const PageScrollPhysics(), // Ensure proper page snapping
                          itemCount: _cards.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final card = _cards[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 220,
                                  maxHeight: 350,
                                  minWidth: 220,
                                  minHeight: 350,
                                ),
                                child: Container(
                                  width: 220,
                                  height: 350,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFF6ED),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                        width: 5,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFF081D5C),
                                      ),
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color.fromARGB(62, 104, 85, 85),
                                        blurRadius: 4,
                                        offset: Offset(0, 4),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: SizedBox(
                                            width: 180,
                                            child: Text(
                                              card['definition'] ??
                                                  'No definition',
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
                                              fontFamily:
                                                  'OPTIFrankfurter-Medium',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16,
                                        top: 35,
                                        child: Image.asset(
                                          'assets/icons/flardspade.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Positioned(
                                        left: 175,
                                        top: 314,
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
                                                fontFamily:
                                                    'OPTIFrankfurter-Medium',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 184,
                                        top: 290,
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
                      top: 550,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: _cards.length,
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
                      top: 620,
                      child: SizedBox(
                        width: 293,
                        height: 111,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _title,
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
                      top: 703.80,
                      child: Image.asset(
                        'assets/icons/terms.png',
                        width: 41.40,
                        height: 25.48,
                      ),
                    ),
                    // Term count
                    Positioned(
                      left: 88.59,
                      top: 710.17,
                      child: SizedBox(
                        width: 69.72,
                        height: 15.29,
                        child: Text(
                          '${_cards.length} terms',
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
                      top: 707.62,
                      child: Image.asset(
                        'assets/icons/user.png',
                        width: 22.40,
                        height: 20.38,
                      ),
                    ),
                    // Username
                    Positioned(
                      left: 178.31,
                      top: 710.17,
                      child: SizedBox(
                        width: 110.69,
                        height: 24.20,
                        child: Text(
                          'by $_username',
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
                      top: 701,
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
                      top: 780,
                      child: GestureDetector(
                        onTap: () {
                          if (_cards.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => StudySet(
                                      setId: widget.setId,
                                      cards: _cards,
                                    ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('No cards available to study!'),
                              ),
                            );
                          }
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
          ],
        ),
      ),
    );
  }
}

class StudySet extends StatefulWidget {
  final String setId;
  final List<dynamic> cards;

  const StudySet({super.key, required this.setId, required this.cards});

  @override
  _StudySetState createState() => _StudySetState();
}

class _StudySetState extends State<StudySet> {
  late PageController _pageController;
  int _currentPage = 0;
  int _correctCount = 0;
  int _incorrectCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (_currentPage != newPage) {
        setState(() {
          _currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _markCorrect() {
    setState(() {
      _correctCount++;
    });
  }

  void _markIncorrect() {
    setState(() {
      _incorrectCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            Positioned(
              left: -46,
              top: -17,
              child: Container(
                width: 513,
                height: 966,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD1E5FE),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF081D5C),
                    ),
                    borderRadius: BorderRadius.circular(56),
                  ),
                ),
              ),
            ),
            // Back button
            Positioned(
              left: 32,
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
              left: 147,
              top: 74,
              child: Image.asset('assets/logo.png', width: 111, height: 44),
            ),
            // Settings button (optional)
            Positioned(
              left: 310,
              top: 77,
              child: Image.asset(
                'assets/icons/settings.png',
                width: 49,
                height: 45,
              ),
            ),
            // Card stack (background card for shadow effect)
            Positioned(
              left: 80,
              top: 264.54,
              child: Container(
                transform:
                    Matrix4.identity()
                      ..translate(0.0, 0.0)
                      ..rotateZ(-0.07),
                width: 230,
                height: 350,
                decoration: ShapeDecoration(
                  color: const Color(0xFF6F96D1),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 5,
                      strokeAlign: BorderSide.strokeAlignOutside,
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
              ),
            ),
            // Main card (PageView for definitions)
            Positioned(
              left: 80,
              top: 249,
              child: SizedBox(
                width: 230,
                height: 350,
                child: PageView.builder(
                  controller: _pageController,
                  clipBehavior: Clip.none,
                  physics: const PageScrollPhysics(),
                  itemCount: widget.cards.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final card = widget.cards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 220,
                          maxHeight: 350,
                          minWidth: 220,
                          minHeight: 350,
                        ),
                        child: Container(
                          width: 220,
                          height: 350,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFFF6ED),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 5,
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: Color(0xFF081D5C),
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color.fromARGB(62, 104, 85, 85),
                                blurRadius: 4,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: SizedBox(
                                    width: 180,
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
                              Positioned(
                                left: 16,
                                top: 35,
                                child: Image.asset(
                                  'assets/icons/flardspade.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              Positioned(
                                left: 175,
                                top: 314,
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
                              Positioned(
                                left: 184,
                                top: 290,
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
            // Card index (e.g., 1/20)
            Positioned(
              left: 154,
              top: 194,
              child: SizedBox(
                width: 173,
                height: 40,
                child: Text(
                  '${_currentPage + 1}/${widget.cards.length}',
                  style: const TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 32,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Previous card button
            Positioned(
              left: 54,
              top: 209,
              child: GestureDetector(
                onTap: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Image.asset(
                  'assets/icons/back.png',
                  width: 39,
                  height: 39,
                ),
              ),
            ),
            // Volume icon (optional)
            Positioned(
              left: 284,
              top: 254,
              child: Opacity(
                opacity: 0.70,
                child: Image.asset(
                  'assets/icons/undo.png',
                  width: 33,
                  height: 33,
                ),
              ),
            ),
            // Incorrect count
            Positioned(
              left: 63,
              top: 712,
              child: SizedBox(
                width: 39,
                height: 25,
                child: Text(
                  '$_incorrectCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 32,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Correct count
            Positioned(
              left: 202,
              top: 711,
              child: SizedBox(
                width: 39,
                height: 25,
                child: Text(
                  '$_correctCount',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 32,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Incorrect button
            Positioned(
              left: 102,
              top: 697,
              child: GestureDetector(
                onTap: _markIncorrect,
                child: Container(
                  width: 81,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF6F96D1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 5,
                        color: Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(13),
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
                  child: Center(
                    child: Image.asset(
                      'assets/icons/idk.png',
                      width: 47,
                      height: 45,
                    ),
                  ),
                ),
              ),
            ),
            // Correct button
            Positioned(
              left: 236,
              top: 697,
              child: GestureDetector(
                onTap: _markCorrect,
                child: Container(
                  width: 81,
                  height: 56,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF6F96D1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 5,
                        color: Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(13),
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
                  child: Center(
                    child: Image.asset(
                      'assets/icons/know.png',
                      width: 48,
                      height: 47,
                    ),
                  ),
                ),
              ),
            ),
            // Share button (optional)
            Positioned(
              left: 330,
              top: 780,
              child: Opacity(
                opacity: 0.70,
                child: Image.asset(
                  'assets/icons/share.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
