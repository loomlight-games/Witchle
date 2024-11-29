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
    fontSize: 20,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    color: letterColor, // Use a predefined color for text
    fontFamily: 'Irish Grover',
  );

  static const TextStyle titleTextStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    color: letterColor,
  );

  static const List<int> letterOptions = [5, 6];
  static const List<int> guessOptions = [4, 5, 6];

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

  // Reusable method to create a DropdownButton
  Widget _buildDropdownButton({
    required String label,
    required int value,
    required List<int> options,
    required ValueChanged<int?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: normalTextStyle,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: specialButtonColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<int>(
              value: value,
              items: options.map((int option) {
                return DropdownMenuItem<int>(
                  value: option,
                  child: Text(
                    option.toString(),
                    style: normalTextStyle, // Apply the same text style here
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              dropdownColor: specialButtonColor,
              icon: Icon(Icons.arrow_drop_down, color: letterColor),
              underline: SizedBox(),
              style: normalTextStyle, // Apply the same text style here
            ),
          ),
        ],
      ),
    );
  }

  // Method to create the credits
  Widget _buildCredits() {
    const List<String> names = [
      'Alfonso Del Pino García',
      'Pascual Gázquez Compán',
      'Paula González Stradiotto',
      'Alba Haro Ballesteros',
      'Cristina Lozano Bautista',
      'Álvaro Moreno García',
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0), // Add vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle('Loomlight'),
          Text(
            'Creadores de Witchle',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              letterSpacing: 1,
              color: letterColor, // Use a predefined color for text
            ),
            textAlign: TextAlign.center, // Center the text horizontally
          ),
          SizedBox(height: 30),
          ...names.map((name) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 2.0), // Add spacing between names
              child: Text(
                name,
                style: normalTextStyle,
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            );
          }),
        ],
      ),
    );
  }

  // WIDGET /////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: buttonInitialColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8.0,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Distribute space
            children: [
              _buildTitle('Ajustes'),
              _buildDropdownButton(
                label: 'Número de letras',
                value: settings.selectedLetters,
                options: letterOptions,
                onChanged: (int? newValue) {
                  setState(() {
                    settings.selectedLetters = newValue!;
                  });
                },
              ),
              _buildDropdownButton(
                label: 'Número de intentos',
                value: settings.selectedGuesses,
                options: guessOptions,
                onChanged: (int? newValue) {
                  setState(() {
                    settings.selectedGuesses = newValue!;
                  });
                },
              ),
              SizedBox(height: 40),
              _buildCredits(),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
