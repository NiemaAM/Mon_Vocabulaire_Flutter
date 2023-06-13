class Progression {
  int userId = 0;
  int subThemeId = 0;
  int quiz = 0;
  int part = 0;
  int stars = 0;
  int mots = 0;

  Progression(
      {required this.userId,
      required this.subThemeId,
      required this.quiz,
      required this.part,
      required this.stars,
      required this.mots});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'subTheme_id': subThemeId,
      'quiz': quiz,
      'part': part,
      'stars': stars,
      'words': mots,
    };
  }
}

class User {
  int? id;
  String name = "";
  String image = "";
  int currentLevel = 1;
  int coins = 0;

  User(
      {this.id,
      required this.name,
      required this.image,
      required this.currentLevel,
      required this.coins});

  Map<String, dynamic> toMap() {
    return {
      'user_id': id,
      'name': name,
      'profil_img': image,
      'level': currentLevel,
      'coins': coins
    };
  }
}
