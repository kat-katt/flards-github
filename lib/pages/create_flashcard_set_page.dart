import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'flashcard_set_preview_page.dart';
import 'flashcard_settings_page.dart' as flashcard;

class CreateFlashcardSetPage extends StatefulWidget {
  const CreateFlashcardSetPage({super.key});

  @override
  _CreateFlashcardSetPageState createState() => _CreateFlashcardSetPageState();
}

class _CreateFlashcardSetPageState extends State<CreateFlashcardSetPage> {
  final _titleController = TextEditingController();
  final List<Map<String, TextEditingController>> _cards = [
    {'term': TextEditingController(), 'definition': TextEditingController()},
  ];

  @override
  void dispose() {
    _titleController.dispose();
    for (var card in _cards) {
      card['term']!.dispose();
      card['definition']!.dispose();
    }
    super.dispose();
  }

  void _addCard() {
    setState(() {
      _cards.add({
        'term': TextEditingController(),
        'definition': TextEditingController(),
      });
    });
  }

  Future<void> _saveSet() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a set title')));
      return;
    }

    for (var card in _cards) {
      if (card['term']!.text.isEmpty || card['definition']!.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All terms and definitions are required'),
          ),
        );
        return;
      }
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      print('User: ${user?.uid}, Email: ${user?.email}');
      if (user == null) {
        throw FirebaseAuthException(
          code: 'no-user',
          message: 'No user is signed in.',
        );
      }

      final setData = {
        'title': _titleController.text,
        'userId': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
        'folderId': null,
        'visibility': 'only_me',
        'editable_by': 'only_me',
        'cards':
            _cards.asMap().entries.map((entry) {
              final index = entry.key;
              final card = entry.value;
              return {
                'term': card['term']!.text,
                'definition': card['definition']!.text,
                'order': index + 1,
              };
            }).toList(),
      };
      print('Saving set: $setData');
      final docRef = await FirebaseFirestore.instance
          .collection('sets')
          .add(setData);

      // Show SetOptions modal after saving
      final result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: 'Dismiss',
        pageBuilder: (context, _, __) => flashcard.SetOptions(setId: docRef.id),
      );

      if (result != null &&
          (result as Map<String, dynamic>)['deleted'] == true) {
        Navigator.pop(context); // Return to previous page (e.g., Profile)
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FlashcardSetPreviewPage(setId: docRef.id),
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error saving set: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6ED),
      body: Stack(
        children: [
          // Main content container
          Positioned(
            left: 14,
            top: 16,
            child: Container(
              width: 360,
              height: 880,
              decoration: ShapeDecoration(
                color: const Color(0xFFD1E5FE),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 4, color: Color(0xFF081D5C)),
                  borderRadius: BorderRadius.circular(56),
                ),
              ),
            ),
          ),
          // Logo
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
              ),
            ),
          ),
          // New set title
          const Positioned(
            left: 59,
            top: 139,
            child: SizedBox(
              width: 273,
              height: 56,
              child: Text(
                'New set',
                style: TextStyle(
                  color: Color(0xFF081D5C),
                  fontSize: 40,
                  fontFamily: 'OPTIFrankfurter-Medium',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          // Set name input
          Positioned(
            left: 28,
            top: 216,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Name',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 19,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: 331,
                  height: 45.75,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFFF6ED),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2.5,
                        color: Color(0xFF081D5C),
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      hintText: 'Enter set title',
                      hintStyle: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 24,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 24,
                      fontFamily: 'OPTIFrankfurter-Medium',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Flashcard list
          Positioned(
            left: 28,
            top: 300,
            child: Container(
              width: 331,
              height: 450,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: 331,
                      height: 180.45,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFF6ED),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 2.5,
                            color: Color(0xFF081D5C),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Term
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Term',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 15,
                                    fontFamily: 'OPTIFrankfurter-Medium',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 255,
                                  child: TextField(
                                    controller: card['term'],
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF081D5C),
                                          width: 2.5,
                                        ),
                                      ),
                                      hintText: 'Enter term',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF081D5C),
                                        fontSize: 20,
                                        fontFamily: 'Questrial',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFF081D5C),
                                      fontSize: 20,
                                      fontFamily: 'Questrial',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Definition
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Definition',
                                  style: TextStyle(
                                    color: Color(0xFF081D5C),
                                    fontSize: 15,
                                    fontFamily: 'OPTIFrankfurter-Medium',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 255,
                                  child: TextField(
                                    controller: card['definition'],
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF081D5C),
                                          width: 2.5,
                                        ),
                                      ),
                                      hintText: 'Enter definition',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF081D5C),
                                        fontSize: 19,
                                        fontFamily: 'Questrial',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    style: const TextStyle(
                                      color: Color(0xFF081D5C),
                                      fontSize: 19,
                                      fontFamily: 'Questrial',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Back button
          Positioned(
            left: 39,
            top: 55,
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
          // Save/Done button
          Positioned(
            left: 307,
            top: 55,
            child: GestureDetector(
              onTap: _saveSet,
              child: Image.asset(
                'assets/icons/save.png',
                width: 45,
                height: 45,
              ),
            ),
          ),
          // Card count
          Positioned(
            left: 150,
            top: 820,
            child: Text(
              '${_cards.length} / ${_cards.length}',
              style: const TextStyle(
                color: Color(0xFF081D5C),
                fontSize: 35,
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Add Card button
          Positioned(
            left: 310,
            top: 764,
            child: GestureDetector(
              onTap: _addCard,
              child: Image.asset(
                'assets/icons/add.png',
                width: 53,
                height: 53,
                color: const Color(0xFF344EAF),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
