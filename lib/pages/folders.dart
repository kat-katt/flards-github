import 'package:flutter/material.dart';
import 'item.dart';
import 'create_flashcard_set_page.dart';

class Folders extends StatelessWidget {
  final Item folder;

  const Folders({super.key, required this.folder});

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
              left: 14,
              top: 18,
              child: Container(
                width: 360,
                height: 878,
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
              left: 40,
              top: 53,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Center(
                    child: Icon(Icons.arrow_back, color: Color(0xFF081D5C), size: 24),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 141,
              top: 50,
              child: Container(
                width: 111,
                height: 44,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage("assets/logo.png"),
                    fit: BoxFit.fill,
                  ),
                  boxShadow: const [
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
              left: 59,
              top: 139,
              child: SizedBox(
                width: 273,
                height: 56,
                child: Text(
                  folder.name,
                  style: const TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 40,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 216,
              child: Container(
                width: 331,
                height: 400,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFFF6ED),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 2.50,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: Color(0xFF081D5C),
                    ),
                    borderRadius: BorderRadius.circular(18),
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
                      'Add a set to this folder!',
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
              left: 28,
              top: 753,
              child: GestureDetector(
                onTap: () {
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
                  width: 331,
                  height: 45.75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF6ED),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.50,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Create Set',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 21,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
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