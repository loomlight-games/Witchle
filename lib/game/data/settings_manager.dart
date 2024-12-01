/// {@template SettingsManager}
/// Manages settings for the number of letters and guesses per word.
/// {@endtemplate}
class SettingsManager {
  /// Singleton instance
  static final SettingsManager _instance = SettingsManager._internal();

  /// Private constructor
  SettingsManager._internal();

  /// Factory constructor to return the singleton instance
  factory SettingsManager() {
    return _instance;
  }

  /// Number of letters selected by the user. Default is 6.
  int selectedLetters = 6;

  /// Number of guesses allowed. Default is 6.
  int selectedGuesses = 6;
}
