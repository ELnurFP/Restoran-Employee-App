/// Extends the [String] class with a `capitalizeWords` method.
extension StringCapitalizer on String {
  /// Returns a new string with the first letter of each word capitalized.
  ///
  /// This method splits the string into words using space as a separator, then capitalizes the first letter of each word and returns the concatenated result.
  ///
  /// Example:
  ///
  /// ```dart
  /// String input = "new password";
  /// String output = input.capitalizeWords();
  /// print(output); // "New Password"
  /// ```
  String capitalizeWords() {
    List<String> words = split(' ');
    String result = '';
    for (int i = 0; i < words.length; i++) {
      result += words[i][0].toUpperCase() + words[i].substring(1);
      if (i < words.length - 1) {
        result += ' ';
      }
    }
    return result;
  }
}
