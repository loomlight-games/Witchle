import 'package:witchle/game/exports.dart';

class Witchle extends StatefulWidget {
  const Witchle({super.key});

  @override
  State<Witchle> createState() => _WitchleState();
}

class _WitchleState extends State<Witchle> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  // PageController to manage page transitions
  final PageController _pageController = PageController(initialPage: 1);

  int _currentScreen = 1; // Initial screen is game

  // METHODS ////////////////////////////////////////////////////////////////

  // Updates current screen and animates to the selected page
  void _navigateToScreen(int nextScreen) {
    // Hide the current SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    setState(() {
      _currentScreen = nextScreen;
    });

    // Animate to the selected page
    _pageController.animateToPage(
      nextScreen,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PageView(
        controller: _pageController,
        children: const [
          TutorialScreen(),
          GameScreen(),
          SettingsScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentScreen = index;
          });
        },
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  AppBar _buildAppBar() {
    const TextStyle titleTextStyle = TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      letterSpacing: 15,
      color: letterColor,
    );

    const TextStyle subtitleTextStyle = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.normal,
      letterSpacing: 1,
      color: letterColor,
    );

    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'WITCHLE',
            style: titleTextStyle,
          ),
          Text(
            '¡Adivina la palabra!',
            style: subtitleTextStyle,
          ),
        ],
      ),
      toolbarHeight: 120.0,
    );
  }

  Widget _buildNavigationBar() {
    return SizedBox(
      height: 56.0, // To set a size for the navigation bar
      child: NavigationBar(
        selectedIndex: _currentScreen,
        onDestinationSelected: _navigateToScreen,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.help_sharp, color: disabledLetterColor),
            selectedIcon: Icon(Icons.help_sharp, color: letterColor),
            label: 'Tutorial',
          ),
          NavigationDestination(
            icon: Icon(Icons.home, color: disabledLetterColor),
            selectedIcon: Icon(Icons.home, color: letterColor),
            label: 'Juego',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: disabledLetterColor),
            selectedIcon: Icon(Icons.settings, color: letterColor),
            label: 'Ajustes',
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
