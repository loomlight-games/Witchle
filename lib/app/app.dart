import 'package:witchle/game/witchle.dart';

/// {@template Letter}
/// Witchle app
/// {@endtemplate}
class App extends StatelessWidget {
  // CONSTRUCTORS ///////////////////////////////////////////////////////////
  
  // Initializer
  const App({super.key});

  // WIDGET /////////////////////////////////////////////////////////////////
  // Sets up a MaterialApp with a dark theme and specifies GameScreen as the home screen
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Witchle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: screenBgColor),
      home: const GameScreen(),
    );
  }
}