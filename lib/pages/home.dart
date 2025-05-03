import 'package:flutter/material.dart';
import 'newfolder.dart';
import 'profile.dart';

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
      Navigator.pushReplacement(
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
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/icon.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          child: Container(
                            width: 23,
                            height: 19,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/spades.png"),
                                fit: BoxFit.cover,
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
                        print('New Set tapped');
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 211,
                        height: 53,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFD1E5FE),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF081D5C),
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
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/create.png"),
                                  fit: BoxFit.cover,
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
                      onTap: () {
                        Navigator.pop(context);
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: false,
                          pageBuilder: (context, _, __) => const NewFolder(),
                          transitionBuilder: (
                            context,
                            animation,
                            secondaryAnimation,
                            child,
                          ) {
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
                            side: const BorderSide(
                              width: 2,
                              color: Color(0xFF081D5C),
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
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/folder.png"),
                                  fit: BoxFit.cover,
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
        physics: const NeverScrollableScrollPhysics(),
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
                  left: 37,
                  top: 110,
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
                  left: 95,
                  top: 130,
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
                  left: 52,
                  top: 126,
                  child: Image(
                    image: const AssetImage("assets/search.png"),
                    width: 27,
                    height: 27,
                    color: const Color(0xFF354FAF),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 190,
                  child: Container(
                    width: 360,
                    height: 1000,
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
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: 360,
                        height: 1000,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 24,
                              top: 25,
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
                              top: 80,
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
                                      child: Image.asset("assets/folder.png"),
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
                              top: 260,
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
                              top: 315,
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
                                      child: Image.asset("assets/folder.png"),
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
