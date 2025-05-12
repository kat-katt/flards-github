import 'package:flard/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'change_username_page.dart';
import 'change_email_page.dart';
import 'change_password_page.dart';

class LogOutConfirmation extends StatelessWidget {
  const LogOutConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      child: SizedBox(
        width: 271,
        height: 304,
        child: Stack(
          children: [
            const Positioned(
              left: 45,
              top: 32,
              child: SizedBox(
                width: 181,
                height: 75,
                child: Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF081D5C),
                    fontSize: 24,
                    fontFamily: 'Questrial',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 125,
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const SignIn()),
                  );
                },
                child: Container(
                  width: 211,
                  height: 53,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFFED1D1),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 2,
                        color: Color(0xFFC02E2E),
                      ),
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Log Out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFC02E2E),
                        fontSize: 25,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 204,
              child: GestureDetector(
                onTap: () {
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
                  child: const Center(
                    child: Text(
                      'Cancel',
                      textAlign: TextAlign.center,
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
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;
  bool _soundEffectsEnabled = false;
  bool _offlineUseEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? false;
      _soundEffectsEnabled = prefs.getBool('sound_effects_enabled') ?? false;
      _offlineUseEnabled = prefs.getBool('offline_use_enabled') ?? false;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = value;
    });
    await prefs.setBool('notifications_enabled', value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notifications ${value ? 'enabled' : 'disabled'}'),
      ),
    );
  }

  Future<void> _toggleSoundEffects(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _soundEffectsEnabled = value;
    });
    await prefs.setBool('sound_effects_enabled', value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sound effects ${value ? 'enabled' : 'disabled'}'),
      ),
    );
  }

  Future<void> _toggleOfflineUse(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _offlineUseEnabled = value;
    });
    await prefs.setBool('offline_use_enabled', value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Offline use ${value ? 'enabled' : 'disabled'}')),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // Full-screen width
        height: MediaQuery.of(context).size.height, // Full-screen height
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.10, 0.37),
            radius: 1.60,
            colors: [Color(0xFF344EAF), Color(0xFF6F96D1)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Container(
                height: 71,
                decoration: const BoxDecoration(
                  color: Color(0xFFD1E5FE),
                  border: Border(
                    bottom: BorderSide(width: 4, color: Color(0xFF081D5C)),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(56),
                    topRight: Radius.circular(56),
                  ),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF081D5C),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    const Text(
                      'Settings',
                      style: TextStyle(
                        color: Color(0xFF081D5C),
                        fontSize: 19,
                        fontFamily: 'OPTIFrankfurter-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 56),
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1E5FE),
                    border: Border.all(
                      width: 4,
                      color: const Color(0xFF081D5C),
                    ),
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: ListView(
                    children: [
                      const Text(
                        'Account details',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 19,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSectionCard(
                        children: [
                          _buildAccountItem(
                            context,
                            title: 'Change username',
                            value: user?.displayName ?? 'parabeenFree',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChangeUsername(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildAccountItem(
                            context,
                            title: 'Change email',
                            value: user?.email ?? 'parabeen@gmail.com',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChangeEmailPage(),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildAccountItem(
                            context,
                            title: 'Change profile picture',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Change profile picture tapped',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildDivider(),
                          _buildAccountItem(
                            context,
                            title: 'Change password',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => const ChangePasswordPage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Offline use',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 19,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSectionCard(
                        children: [
                          SwitchListTile(
                            title: const Text(
                              'Save sets for offline use',
                              style: TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 15,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: const Text(
                              'Your 10 most recently used sets will be downloaded automatically',
                              style: TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 15,
                                fontFamily: 'Questrial',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            value: _offlineUseEnabled,
                            onChanged: _toggleOfflineUse,
                            activeColor: const Color(0xFF344EAF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Preferences',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 19,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSectionCard(
                        children: [
                          SwitchListTile(
                            title: const Text(
                              'Push Notifications',
                              style: TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 18,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: _notificationsEnabled,
                            onChanged: _toggleNotifications,
                            activeColor: const Color(0xFF344EAF),
                          ),
                          _buildDivider(),
                          SwitchListTile(
                            title: const Text(
                              'Sound Effects',
                              style: TextStyle(
                                color: Color(0xFF081D5C),
                                fontSize: 18,
                                fontFamily: 'OPTIFrankfurter-Medium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: _soundEffectsEnabled,
                            onChanged: _toggleSoundEffects,
                            activeColor: const Color(0xFF344EAF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'About',
                        style: TextStyle(
                          color: Color(0xFF081D5C),
                          fontSize: 19,
                          fontFamily: 'OPTIFrankfurter-Medium',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildSectionCard(
                        children: [
                          _buildAboutItem(
                            context,
                            title: 'Privacy Policy',
                            onTap: () {
                              _launchUrl('https://example.com/privacy-policy');
                            },
                          ),
                          _buildDivider(),
                          _buildAboutItem(
                            context,
                            title: 'Terms of Service',
                            onTap: () {
                              _launchUrl('https://example.com/terms');
                            },
                          ),
                          _buildDivider(),
                          _buildAboutItem(
                            context,
                            title: 'Help Center',
                            onTap: () {
                              _launchUrl('https://example.com/help');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildActionButton(
                            context,
                            title: 'Log Out',
                            width: 121,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => const LogOutConfirmation(),
                              );
                            },
                          ),
                          _buildActionButton(
                            context,
                            title: 'Delete Account',
                            width: 188,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (context) => Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: SizedBox(
                                        width: 271,
                                        height: 304,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 45,
                                              top: 32,
                                              child: SizedBox(
                                                width: 181,
                                                height: 75,
                                                child: Text(
                                                  'Are you sure you want to delete your account?',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Color(0xFF081D5C),
                                                    fontSize: 24,
                                                    fontFamily: 'Questrial',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 30,
                                              top: 125,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  try {
                                                    User? user =
                                                        FirebaseAuth
                                                            .instance
                                                            .currentUser;
                                                    if (user == null) {
                                                      throw FirebaseAuthException(
                                                        code: 'no-user',
                                                        message:
                                                            'No user is signed in.',
                                                      );
                                                    }
                                                    await user.delete();
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                const SignIn(),
                                                      ),
                                                    );
                                                  } catch (e) {
                                                    Navigator.pop(context);
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          'Error deleting account: $e',
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Container(
                                                  width: 211,
                                                  height: 53,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(
                                                      0xFFFED1D1,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                        width: 2,
                                                        color: Color(
                                                          0xFFC02E2E,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            19,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Delete',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFFC02E2E,
                                                        ),
                                                        fontSize: 25,
                                                        fontFamily:
                                                            'OPTIFrankfurter-Medium',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 30,
                                              top: 204,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Container(
                                                  width: 211,
                                                  height: 53,
                                                  decoration: ShapeDecoration(
                                                    color: const Color(
                                                      0xFFD1E5FE,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                        width: 2,
                                                        color: Color(
                                                          0xFF081D5C,
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            19,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      'Cancel',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color(
                                                          0xFF081D5C,
                                                        ),
                                                        fontSize: 25,
                                                        fontFamily:
                                                            'OPTIFrankfurter-Medium',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: Color(0xFF081D5C)),
          borderRadius: BorderRadius.circular(26),
        ),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildAccountItem(
    BuildContext context, {
    required String title,
    String? value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF081D5C),
          fontSize: 18,
          fontFamily: 'OPTIFrankfurter-Medium',
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle:
          value != null
              ? Text(
                value,
                style: const TextStyle(
                  color: Color(0xFF081D5C),
                  fontSize: 18,
                  fontFamily: 'Questrial',
                  fontWeight: FontWeight.w400,
                ),
              )
              : null,
      trailing: const Icon(Icons.edit, color: Color(0xFF081D5C)),
      onTap: onTap,
    );
  }

  Widget _buildAboutItem(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF081D5C),
          fontSize: 18,
          fontFamily: 'OPTIFrankfurter-Medium',
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward, color: Color(0xFF081D5C)),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 3,
      color: const Color(0xFF081D5C),
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String title,
    required double width,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 56,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 3, color: Color(0xFF081D5C)),
            borderRadius: BorderRadius.circular(26),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF081D5C),
              fontSize: 19,
              fontFamily: 'OPTIFrankfurter-Medium',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
