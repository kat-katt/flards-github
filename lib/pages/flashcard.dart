import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'flashcard_settings_page.dart';

class Flashcard extends StatefulWidget {
  final String setId;

  const Flashcard({super.key, required this.setId});

  @override
  _FlashcardState createState() => _FlashcardState();
}

class _FlashcardState extends State<Flashcard> {
  late Future<DocumentSnapshot> _setFuture;
  int _currentCardIndex = 0;
  List<Map<String, dynamic>> _cards = [];
  bool _showDefinition = false;

  @override
  void initState() {
    super.initState();
    _setFuture = FirebaseFirestore.instance
        .collection('sets')
        .doc(widget.setId)
        .get();
  }

  void _nextCard() {
    if (_currentCardIndex < _cards.length - 1) {
      setState(() {
        _currentCardIndex++;
        _showDefinition = false;
      });
    }
  }

  void _previousCard() {
    if (_currentCardIndex > 0) {
      setState(() {
        _currentCardIndex--;
        _showDefinition = false;
      });
    }
  }

  void _toggleCardSide() {
    setState(() {
      _showDefinition = !_showDefinition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _setFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('Set not found'));
        }

        final setData = snapshot.data!.data() as Map<String, dynamic>;
        _cards = List<Map<String, dynamic>>.from(setData['cards'] ?? []);
        if (_cards.isEmpty) {
          return Center(child: Text('No cards in this set'));
        }

        final currentCard = _cards[_currentCardIndex];
        final term = currentCard['term'] ?? 'No Term';
        final definition = currentCard['definition'] ?? 'No Definition';

        return Column(
          children: [
            Container(
              width: 390,
              height: 844,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
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
                            color: const Color(0xFF081D5C),
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
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/back.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 42.53,
                    top: 85.78,
                    child: Container(
                      width: 22.02,
                      height: 20.85,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/22x21"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 54,
                    top: 209,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage("https://placehold.co/39x39"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Set title placeholder (can be dynamic later)
                  Positioned(
                    left: 147,
                    top: 74,
                    child: Container(
                      width: 111,
                      height: 44,
                      child: Center(
                        child: Text(
                          setData['title'] ?? 'Set Title',
                          style: TextStyle(
                            color: const Color(0xFF081D5C),
                            fontSize: 24,
                            fontFamily: 'OPTIFrankfurter-Medium',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Settings button
                  Positioned(
                    left: 310,
                    top: 77,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/icons/settings.png',
                        width: 49,
                        height: 45,
                      ),
                    ),
                  ),
                  // Card layers (visual effect)
                  Positioned(
                    left: 63,
                    top: 264.54,
                    child: Container(
                      transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-0.07),
                      width: 229,
                      height: 365,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF6F96D1),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 5,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: const Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 98,
                    top: 249,
                    child: Container(
                      width: 229,
                      height: 365,
                      decoration: ShapeDecoration(
                        color: const Color(0x5B354FAF),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 5,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: const Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                  // Main card
                  Positioned(
                    left: 98,
                    top: 249,
                    child: GestureDetector(
                      onTap: _toggleCardSide,
                      child: Container(
                        width: 229,
                        height: 365,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFF6ED),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 5,
                              color: const Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              _showDefinition ? definition : term,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xFF081D5C),
                                fontSize: 24,
                                fontFamily: 'Questrial',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Card count
                  Positioned(
                    left: 154,
                    top: 194,
                    child: SizedBox(
                      width: 173,
                      height: 40,
                      child: Text(
                        '${_currentCardIndex + 1}/${_cards.length}',
                        style: TextStyle(
                          color: const Color(0xFF081D5C),
                          fontSize: 32,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  // Previous card button
                  Positioned(
                    left: 102,
                    top: 697,
                    child: GestureDetector(
                      onTap: _previousCard,
                      child: Container(
                        width: 81,
                        height: 56,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF6F96D1),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 5,
                              color: const Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: const Color(0xFF081D5C),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Next card button
                  Positioned(
                    left: 236,
                    top: 697,
                    child: GestureDetector(
                      onTap: _nextCard,
                      child: Container(
                        width: 81,
                        height: 56,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF6F96D1),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 5,
                              color: const Color(0xFF081D5C),
                            ),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          shadows: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: const Color(0xFF081D5C),
                            size: 30,
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
      },
    );
  }
}