// ignore_for_file: non_constant_identifier_names, file_names

class User {
  int id = 0;
  String name = "";
  String image = "";
  int current_level = 1;
  Map<int, int> words_per_level = {};
  Map<int, int> words_per_subtheme = {};
  Map<int, bool> stars_per_subtheme = {};
  int coins = 0;
  User(
      {required this.id,
      required this.name,
      required this.image,
      required this.current_level,
      required this.words_per_level,
      required this.words_per_subtheme,
      required this.stars_per_subtheme,
      required this.coins});
}
