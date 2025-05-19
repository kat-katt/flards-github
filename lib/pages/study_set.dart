import 'package:flutter/material.dart';

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
    _pageController = PageController(viewportFraction: 1.0);
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
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('End of set reached!')));
      }
    });
  }

  void _markIncorrect() {
    setState(() {
      _incorrectCount++;
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('End of set reached!')));
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity! > 0 && _currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    } else if (details.primaryVelocity! < 0 &&
        _currentPage < widget.cards.length - 1) {
      setState(() {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: Container(
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
                left: 85,
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
                left: 85,
                top: 249,
                child: SizedBox(
                  width: 230,
                  height: 350,
                  child: PageView.builder(
                    controller: _pageController,
                    clipBehavior: Clip.none,
                    physics:
                        const NeverScrollableScrollPhysics(), // Disable manual swiping
                    itemCount: widget.cards.length,
                    itemBuilder: (context, index) {
                      final card = widget.cards[index];
                      return Container(
                        width: 230,
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
                      );
                    },
                  ),
                ),
              ),
              // Card index (e.g., 1/20)
              Positioned(
                left: 0,
                top: 194,
                right: 0,
                child: Center(
                  child: SizedBox(
                    width: 173,
                    height: 40,
                    child: Text(
                      '${_currentPage + 1}/${widget.cards.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 32,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              // Previous card button (hint icon)
              Positioned(
                left: 54,
                top: 209,
                child: GestureDetector(
                  onTap: () {
                    if (_currentPage > 0) {
                      setState(() {
                        _currentPage--;
                        _pageController.animateToPage(
                          _currentPage,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      });
                    }
                  },
                  child: Image.asset(
                    'assets/icons/hint.png',
                    width: 39,
                    height: 39,
                  ),
                ),
              ),
              // Hint icon (optional)
              Positioned(
                left: 284,
                top: 254,
                child: Opacity(
                  opacity: 0.70,
                  child: Image.asset(
                    'assets/icons/hint.png',
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
                        width: 60,
                        height: 60,
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
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ),
              // Pomodoro button
              Positioned(
                left: 330,
                top: 780,
                child: Opacity(
                  opacity: 0.70,
                  child: Image.asset(
                    'assets/icons/pomodoro.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
