import 'package:flutter/material.dart';

class ChangeBio extends StatefulWidget {
  final Function(String) onSave;

  const ChangeBio({required this.onSave, super.key});

  @override
  _ChangeBioState createState() => _ChangeBioState();
}

class _ChangeBioState extends State<ChangeBio> {
  final TextEditingController _bioController = TextEditingController();
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {
      setState(() {
        _charCount = _bioController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  void _saveBio() {
    widget.onSave(_bioController.text);
    Navigator.pop(context);
  }

  void _goBack() {
    Navigator.pop(context); // Close the dialog without saving
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 300,
            height: 289,
            decoration: BoxDecoration(
              boxShadow: [
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
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 300,
                    height: 289,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFFF6ED),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 7,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: const Color(0xFF081D5C),
                        ),
                        borderRadius: BorderRadius.circular(37),
                      ),
                      shadows: [
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
                  left: 96,
                  top: 48,
                  child: SizedBox(
                    width: 130,
                    height: 27,
                    child: Text(
                      'Edit your bio',
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
                  left: 21,
                  top: 21,
                  child: GestureDetector(
                    onTap: _goBack,
                    child: Container(
                      width: 47,
                      height: 41,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/spade_back.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 88,
                  child: Container(
                    width: 245,
                    height: 128,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD1E5FE),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignCenter,
                          color: const Color(0xFF081D5C),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: TextField(
                        controller: _bioController,
                        maxLength: 100,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          hintText: 'Welcome to my account!',
                          hintStyle: TextStyle(
                            color: const Color(0xFF081D5C).withOpacity(0.3),
                            fontSize: 20,
                            fontFamily: 'Questrial',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        style: TextStyle(
                          color: const Color(0xFF081D5C),
                          fontSize: 20,
                          fontFamily: 'Questrial',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 205,
                  top: 185,
                  child: SizedBox(
                    width: 72,
                    height: 20,
                    child: Text(
                      '$_charCount/100',
                      style: TextStyle(
                        color: const Color(0xFF6F96D1),
                        fontSize: 20,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 88,
                  top: 234,
                  child: GestureDetector(
                    onTap: _saveBio,
                    child: Container(
                      width: 124,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: RadialGradient(
                          center: Alignment(1.23, -0.17),
                          radius: 5.88,
                          colors: [
                            const Color(0xFF344EAF),
                            const Color(0xFF6F96D1),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 56,
                          height: 30,
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: const Color(0xFFFFF6ED),
                              fontSize: 24,
                              fontFamily: 'OPTIFrankfurter-Medium',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
    );
  }
}
