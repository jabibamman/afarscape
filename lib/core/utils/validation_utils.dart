class UrlValidator {
  static bool isValid(String? url) {
    final urlRegex = RegExp(
      r"^(http|https):\/\/[^\s$.?#].[^\s]*$",
      caseSensitive: false,
    );
    return url != null && urlRegex.hasMatch(url);
  }
}