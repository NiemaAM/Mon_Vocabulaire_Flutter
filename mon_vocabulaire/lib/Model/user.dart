// ignore_for_file: non_constant_identifier_names, file_names

/* class User {
  int id = 0;
  String name = "";
  String image = "";
  int current_level = 1;
  Map<int, int> words_per_level = {};
  Map<int, int> words_per_subtheme = {};
  Map<int, int> stars_per_subtheme = {};
  Map<int, Map<int, bool>> status_per_Subtheme = {};
  int coins = 0;

  User(
      {required this.id,
      required this.name,
      required this.image,
      required this.current_level,
      required this.words_per_level,
      required this.words_per_subtheme,
      required this.stars_per_subtheme,
      required this.status_per_Subtheme,
      required this.coins});
} */

class Sub_theme {
  int id = 0;
  String name_sub_theme = "";

  Sub_theme({
    required this.id,
    required this.name_sub_theme,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_sub_theme': id,
      'name_sub_theme': name_sub_theme,
    };
  }
}

class Quiz {
  int id = 0;
  String name_quiz = "";
  bool state = false;

  Quiz({required this.id, required this.name_quiz});

  Map<String, dynamic> toMap() {
    return {
      'id_quiz': id,
      'name_quiz': name_quiz,
    };
  }
}

class Progression {
  int id = 0;
  int sub_theme_id = 0;
  int quiz_id = 0;
  int lesson = 0;
  int stars = 0;
  int mots = 0;

  Progression(
      {required this.id,
      required this.sub_theme_id,
      required this.quiz_id,
      required this.lesson,
      required this.stars,
      required this.mots});
}

class User {
  int? id;
  String name = "";
  String image = "";
  int current_level = 1;
  int coins = 0;

  User(
      {this.id,
      required this.name,
      required this.image,
      required this.current_level,
      required this.coins});

  Map<String, dynamic> toMap() {
    return {
      'id_user': id,
      'name': name,
      'profil_img': image,
      'level': current_level,
      'coins': coins
    };
  }
}
