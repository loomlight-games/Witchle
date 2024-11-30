import 'package:witchle/game/exports.dart';

// Executable method
// Runs app by calling the runApp function with
// an instance of App class
void main() {
  // Ensure that plugin services are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // App only runs after the preferred orientation is set
    runApp(const App());
  });
}
