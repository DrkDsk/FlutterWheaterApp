extension StringExtension on String {

  String firstUppercase() {
    if (isEmpty) return this;

    return split(' ')
        .map((word) =>
    word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
        .join(' ');
  }

}