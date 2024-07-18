class StringUtils {
  static String truncate(String stringToCut, int lengthToCutTo) {
    if (stringToCut.length > lengthToCutTo) {
      return "${stringToCut.substring(0, lengthToCutTo)}...";
    }
    return stringToCut;
  }
  static String capitalizeText(String text) {
  return text.isEmpty ? "" : text[0].toUpperCase() + text.substring(1);
}
}
