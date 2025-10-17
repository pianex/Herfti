String shrinkLikesFormula(int likes) {
  String result = '';
  if (likes < 1000) {
    result = '$likes';
  } else if (likes >= 1000) {
    result = "${(likes / 1000).toStringAsFixed(1).replaceFirst(".0", "")}k";
  }
  return result;
}
