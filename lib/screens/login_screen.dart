import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart'; // Assuming AssetListScreen is renamed or located here

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _textController = TextEditingController();
  String? _selectedLanguage;
  bool _showDropdown = false;

  List<String> languages = ['English', 'Hindi', 'Bengali', 'Marathi'];

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _textController.addListener(() {
      if (_textController.text.length == 10 && !_showDropdown) {
        setState(() {
          _showDropdown = true;
        });
      } else if (_textController.text.length != 10 && _showDropdown) {
        setState(() {
          _showDropdown = false;
          _selectedLanguage = null;
        });
      }
    });
  }

  Future<void> _checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      debugPrint('Checking login status: isLoggedIn=$isLoggedIn');
      if (isLoggedIn) {
        // Navigate to HomeScreen and clear navigation stack
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
        );
      }
    } catch (e) {
      debugPrint('Error checking login status: $e');
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final employeeId = _textController.text;
    final language = _selectedLanguage;
    debugPrint('Entered Code: $employeeId');
    debugPrint('Selected Language: $language');

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('employeeId', employeeId);
      await prefs.setString('language', language ?? 'English');
      await prefs.setBool('isLoggedIn', true);
      debugPrint('Saved to SharedPreferences: employeeId=$employeeId, language=$language, isLoggedIn=true');
    } catch (e) {
      debugPrint('Error saving to SharedPreferences: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving login data'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600; // Tablet threshold
    final maxContentWidth = isTablet ? 500.0 : double.infinity;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: isTablet ? _buildTabletLayout(context, maxContentWidth) : _buildMobileLayout(context, maxContentWidth),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double maxContentWidth) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/loginbgImage.jpg',
            fit: BoxFit.cover,
          ),
        ),
        // White overlay
        Positioned.fill(
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        // Content
        SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: maxContentWidth,
                child: _buildLoginContent(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context, double maxContentWidth) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    return Row(
      children: [
        // Left: Tablet View Background image
        Expanded(
          flex: 2,
          child: Image.asset(
            'assets/TabloginImage.png',
            fit: isLandscape ? BoxFit.fill : BoxFit.fitHeight,
            alignment: isLandscape ? Alignment.center : Alignment.centerLeft,
          ),
        ),
        // Right: Content with overlay
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white.withOpacity(0.8),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: maxContentWidth,
                    child: _buildLoginContent(context),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/bull-machine-logo 1.png',
            width: 150,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          'LOG IN',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _textController,
          maxLength: 10,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: 'Enter your Employee ID *',
            labelStyle: TextStyle(color: Color(0xFF000000)),
          ),
        ),
        if (_showDropdown) const SizedBox(height: 20),
        if (_showDropdown)
          SizedBox(
            width: 200,
            child: DropdownButtonFormField<String>(
              value: _selectedLanguage,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                labelText: 'Select Language',
                labelStyle: TextStyle(color: Colors.black),
              ),
              items: languages.map((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Text(lang),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
            ),
          ),
        if (_showDropdown) const SizedBox(height: 10),
        if (_showDropdown)
          const Text(
            'Media will be downloaded in chosen languages',
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF000000),
            ),
          ),
        if (_showDropdown && _selectedLanguage != null) const SizedBox(height: 20),
        if (_showDropdown && _selectedLanguage != null)
          Center(
            child: SizedBox(
              width: 400,
              height: 50,
              child: ElevatedButton(
                onPressed: _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB92F),
                  foregroundColor: Colors.black,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Log In'),
              ),
            ),
          ),
      ],
    );
  }
}