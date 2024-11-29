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
    setState(() {
      _currentScreen = nextScreen;
    });
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  // Uses a Scaffold widget to create a layout with an AppBar and a body
  // containing a game board and a keyboard.
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: _screens[_currentScreen],
        bottomNavigationBar: bottomBar());
  }

  AppBar appBar() {
    return AppBar(
      // Centered title and transparent background
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: CircleBorder(eccentricity: BorderSide.strokeAlignCenter),
      title: const Text('WITCHLE',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            letterSpacing: 15,
            color: letterColor,
          )),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      currentIndex: _currentScreen,
      onTap: _navigateToScreen,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.help_sharp, color: letterColor),
            label: 'Tutorial'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home, color: letterColor), label: 'Juego'),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: letterColor), label: 'Ajustes'),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
