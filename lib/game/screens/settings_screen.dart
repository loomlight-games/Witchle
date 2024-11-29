import 'package:witchle/game/exports.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // PROPERTIES ////////////////////////////////////////////////////////////

  // Define a TextStyle for normal text to ensure consistency
  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: letterColor, // Use a predefined color for text
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: letterColor,
  );

  static const List<int> letterOptions = [5, 6];
  static const List<int> guessOptions = [3, 4, 6];

  // Access the singleton instance
  final SettingsManager settings = SettingsManager();

  // METHODS ////////////////////////////////////////////////////////////////
  // Method to create the title widget
  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0), // Add vertical padding
      child: Text(
        title, // Display the title text
        style: titleTextStyle,
        textAlign: TextAlign.center, // Center the text horizontally
      ),
    );
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // Build method to construct the UI of the screen
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity, // Make the container take full width
              margin:
                  const EdgeInsets.all(10.0), // Add margin around the container
              decoration: BoxDecoration(
                color: buttonInitialColor, // Background color for the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black, // Shadow color
                    blurRadius: 8.0, // Shadow blur radius
                    offset: Offset(0, 10), // Shadow offset
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    12.0), // Ensure content respects the border radius
                child: SingleChildScrollView(
                  // Use SingleChildScrollView to prevent overflow
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildTitle('Ajustes'),
                      const Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          'Número de letras:',
                          textAlign:
                              TextAlign.center, // Center the text horizontally
                          style: normalTextStyle,
                        ),
                      ),
                      DropdownButton<int>(
                        value: settings.selectedLetters,
                        items: letterOptions.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            settings.selectedLetters = newValue!;
                          });
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          'Número de intentos:',
                          textAlign:
                              TextAlign.center, // Center the text horizontally
                          style: normalTextStyle,
                        ),
                      ),
                      DropdownButton<int>(
                        value: settings.selectedGuesses,
                        items: guessOptions.map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            settings.selectedGuesses = newValue!;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
