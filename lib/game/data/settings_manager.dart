class SettingsManager {
  // Singleton instance
  static final SettingsManager _instance = SettingsManager._internal();

  // Private constructor
  SettingsManager._internal();

  // Factory constructor to return the singleton instance
  factory SettingsManager() {
    return _instance;
  }

  // Variables to store the selected options
  int selectedLetters = 6;
  int selectedGuesses = 6;
}
