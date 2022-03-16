extension StringExtensions on String {
  String replaceAllWeirdCharacters() {
    return replaceAll(RegExp('[^A-Za-z0-9]'), '');
  }
}