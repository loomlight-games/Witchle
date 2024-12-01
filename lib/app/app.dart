import 'package:witchle/game/exports.dart'; // Imports necessary dependencies from the 'witchle' package

/// {@template Letter}
/// Witchle app
/// {@endtemplate}
class App extends StatelessWidget {
  // CONSTRUCTORS ///////////////////////////////////////////////////////////

  // Initializer
  // Constructor for the App class, using a constant constructor with a super key
  const App({super.key});

  // WIDGET /////////////////////////////////////////////////////////////////
  // Sets up a MaterialApp with a dark theme and specifies GameScreen as the home screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sets the title of the application
      title: 'Witchle',
      // Disables the debug banner in the top-right corner of the app
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Sets the theme brightness to dark
        // Sets the background color of the scaffold to 'screenBgColor'
        scaffoldBackgroundColor: screenBgColor,
        // Sets the default font family to 'Irish Grover'
        fontFamily: 'Irish Grover',
      ),
      home:
          const Witchle(), // Sets the home screen of the app to the 'Witchle' widget
    );
  }
}
