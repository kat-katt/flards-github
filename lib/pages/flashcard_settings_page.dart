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
          (context) => AlertDialog(
            title: const Text(
              'Delete Set',
              style: TextStyle(
                color: Color(0xFF081D5C),
                fontFamily: 'OPTIFrankfurter-Medium',
                fontWeight: FontWeight.w500,
              ),
            ),
            content: const Text(
              'Are you sure you want to delete this set?',
              style: TextStyle(
                color: Color(0xFF081D5C),
                fontFamily: 'Questrial',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontFamily: 'OPTIFrankfurter-Medium',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteSet();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Color(0xFFC02E2E),
                    fontFamily: 'OPTIFrankfurter-Medium',
                  ),
                ),
              ),
            ],
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
