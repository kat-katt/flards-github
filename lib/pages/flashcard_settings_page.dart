import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class SetOptions extends StatefulWidget {
  final String setId;

  const SetOptions({super.key, required this.setId});

  @override
  _SetOptionsState createState() => _SetOptionsState();
}

class _SetOptionsState extends State<SetOptions> {
  String _visibility = 'only_me';
  String _editableBy = 'only_me';
  final firestore.FirebaseFirestore _firestore =
      firestore.FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      firestore.DocumentSnapshot setDoc =
          await _firestore.collection('sets').doc(widget.setId).get();
      if (setDoc.exists) {
        setState(() {
          _visibility = setDoc.get('visibility') ?? 'only_me';
          _editableBy = setDoc.get('editable_by') ?? 'only_me';
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading settings: $e')));
    }
  }

  Future<void> _updateSetting(String field, String value) async {
    try {
      await _firestore.collection('sets').doc(widget.setId).set({
        field: value,
      }, firestore.SetOptions(merge: true));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error updating $field: $e')));
    }
  }

  Future<void> _deleteSet() async {
    try {
      await _firestore.collection('sets').doc(widget.setId).delete();
      Navigator.pop(context, {'deleted': true});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting set: $e')));
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: ConfirmDeletion(
                onDelete: _deleteSet,
                onCancel: () => Navigator.pop(context),
              ),
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 324,
        height: 404,
        decoration: ShapeDecoration(
          color: const Color(0xFFD1E5FE),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Color(0xFF081D5C)),
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Stack(
          children: [
            // Title
            Positioned(
              left: 83,
              top: 57,
              child: const SizedBox(
                width: 179,
                height: 42,
                child: Text(
                  'Set options',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 32,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Privacy Section
            Positioned(
              left: 45,
              top: 133,
              child: const SizedBox(
                width: 120,
                height: 15,
                child: Text(
                  'Privacy',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 12,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Visible To
            Positioned(
              left: 33,
              top: 155,
              child: Container(
                width: 252,
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
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.visibility,
                      color: Color(0xFF081D5C),
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Visible to',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 13,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _visibility,
                      items: const [
                        DropdownMenuItem(
                          value: 'only_me',
                          child: Text('Only me'),
                        ),
                        DropdownMenuItem(
                          value: 'public',
                          child: Text('Public'),
                        ),
                        DropdownMenuItem(
                          value: 'friends',
                          child: Text('Friends'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _visibility = value;
                          });
                          _updateSetting('visibility', value);
                        }
                      },
                      underline: const SizedBox(),
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            // Editable By
            Positioned(
              left: 33,
              top: 215,
              child: Container(
                width: 252,
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
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    const Icon(Icons.edit, color: Color(0xFF081D5C), size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Editable by',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 13,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    DropdownButton<String>(
                      value: _editableBy,
                      items: const [
                        DropdownMenuItem(
                          value: 'only_me',
                          child: Text('Only me'),
                        ),
                        DropdownMenuItem(
                          value: 'collaborators',
                          child: Text('Collaborators'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _editableBy = value;
                          });
                          _updateSetting('editable_by', value);
                        }
                      },
                      underline: const SizedBox(),
                      style: const TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 16,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            // Delete Set Button
            Positioned(
              left: 55,
              top: 313,
              child: GestureDetector(
                onTap: _confirmDelete,
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
                  child: const Center(
                    child: Text(
                      'Delete set',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 25,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Close Button
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Color(0xFF081D5C),
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmDeletion extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const ConfirmDeletion({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 271,
      height: 338,
      child: Stack(
        alignment: Alignment.center, // Center the stack's children
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 271,
              height: 338,
              decoration: ShapeDecoration(
                color: const Color(0xFFFFF6ED),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 6,
                    strokeAlign: BorderSide.strokeAlignOutside,
                    color: const Color(0xFFC02E2E),
                  ),
                  borderRadius: BorderRadius.circular(51),
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
            left: 50,
            top: 44,
            child: SizedBox(
              width: 174,
              height: 53,
              child: Text(
                'Confirm',
                textAlign: TextAlign.center, // Center the text
                style: TextStyle(
                  color: const Color(0xFFC02E2E),
                  fontSize: 40,
                  fontFamily: 'OPTIFrankfurter-Medium',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: 136,
            child: GestureDetector(
              onTap: onDelete,
              child: Container(
                width: 211,
                height: 53,
                decoration: ShapeDecoration(
                  color: const Color(0xFFFED1D1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: const Color(0xFFC02E2E)),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/delete.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 136,
                      height: 34,
                      child: Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFC02E2E),
                          fontSize: 25,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 31,
            top: 218,
            child: GestureDetector(
              onTap: onCancel,
              child: Container(
                width: 211,
                height: 53,
                decoration: ShapeDecoration(
                  color: const Color(0xFFD1E5FE),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: const Color(0xFF081D5C)),
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/cancel.png',
                      width: 33,
                      height: 33,
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 95,
                      height: 34,
                      child: Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFF081D5C),
                          fontSize: 25,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
