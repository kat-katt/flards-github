import 'package:flutter/material.dart';

class NewFolder extends StatefulWidget {
  const NewFolder({super.key});

  @override
  State<NewFolder> createState() => _NewFolderState();
}

class _NewFolderState extends State<NewFolder> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();

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
              left: 308,
              top: 53,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Back to HomePage (as before)
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://placehold.co/45x45"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Color(0xFF081D5C),
                      size: 24,
                    ), // Using a close icon
                  ),
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 53,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(
                    context,
                  ); // Navigate back to the previous screen (HomePage)
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    // You can remove the image decoration if you just want the icon
                    // image: DecorationImage(
                    //   image: NetworkImage("https://placehold.co/45x45"),
                    //   fit: BoxFit.fill,
                    // ),
                    color:
                        Colors
                            .transparent, // Make the background transparent for the icon
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF081D5C),
                      size: 24,
                    ), // Using a back arrow icon
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
                ),
              ),
            ),
            const Positioned(
              left: 59,
              top: 139,
              child: SizedBox(
                width: 273,
                height: 56,
                child: Text(
                  'New folder',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 40,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 44,
              top: 216,
              child: SizedBox(
                width: 282.40,
                height: 23.55,
                child: Text(
                  'Name',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 19,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 250.31,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name of the folder',
                      hintStyle: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 19,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 19,
                      fontFamily: 'OPTIFrankfurter-Medium',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 44,
              top: 317,
              child: SizedBox(
                width: 282.40,
                height: 77.44,
                child: Text(
                  'Description (Optional)',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 19,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 354.18,
              child: Container(
                width: 331,
                height: 150.45,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter description...',
                      hintStyle: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 25,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 25,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 44,
              top: 528,
              child: SizedBox(
                width: 282.40,
                height: 23.55,
                child: Text(
                  'Tags',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 19,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 563.33,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _tagsController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'major subject, prefinals',
                      hintStyle: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 25,
                        fontFamily: 'Questrial',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: const TextStyle(
                      color: Color(0xFF081D5C),
                      fontSize: 25,
                      fontFamily: 'Questrial',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 44,
              top: 631,
              child: SizedBox(
                width: 282.40,
                height: 23.55,
                child: Text(
                  'Privacy',
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 19,
                    fontFamily: 'OPTIFrankfurter-Medium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 29,
              top: 666,
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Private',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 19,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 23, height: 25, child: Placeholder()),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 753,
              child: GestureDetector(
                onTap: () {
                  // Add your add set logic here
                  print('Add Set tapped');
                  print('Name: ${_nameController.text}');
                  print('Description: ${_descriptionController.text}');
                  print('Tags: ${_tagsController.text}');
                  Navigator.pop(context); // Return to HomePage
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
                      'Add Set',
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
