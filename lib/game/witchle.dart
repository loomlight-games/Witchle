import 'package:witchle/game/exports.dart';

class Witchle extends StatefulWidget {
  const Witchle({super.key});

  @override
  State<Witchle> createState() => _WitchleState();
}

class _WitchleState extends State<Witchle> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  // List of screens in navBar order
  final List _screens = [TutorialScreen(), GameScreen(), SettingsScreen()];

  int _currentScreen = 1; // Initial screen is game

  // METHODS ////////////////////////////////////////////////////////////////

  // Updates current screen
  void _navigateToScreen(int nextScreen) {
    // Hide the current SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() {
      _currentScreen = nextScreen;
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: _screens[_currentScreen],
      bottomNavigationBar: bottomBar(),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'WITCHLE',
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              letterSpacing: 15,
              color: letterColor,
            ),
          ),
          const Text(
            '¡Adivina la palabra!',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              letterSpacing: 1,
              color: letterColor,
            ),
          ),
        ],
      ),
      toolbarHeight: 120.0,
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentScreen,
      onTap: _navigateToScreen,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.help_sharp, color: disabledLetterColor),
          label: 'Tutorial',
          activeIcon: Icon(Icons.help_sharp, color: letterColor),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: disabledLetterColor),
          activeIcon: Icon(Icons.home, color: letterColor),
          label: 'Juego',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings, color: disabledLetterColor),
          activeIcon: Icon(Icons.settings, color: letterColor),
          label: 'Ajustes',
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
