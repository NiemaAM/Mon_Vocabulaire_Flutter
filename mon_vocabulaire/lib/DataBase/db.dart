import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../Model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  late Future<Database> _databaseFuture;

  DatabaseHelper.internal() {
    _databaseFuture = initDatabase();
  }

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await _databaseFuture;
    return _db!;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'mon_vocabulaire.db'),
      onCreate: (db, version) async {
        await db.execute(
            " CREATE TABLE Users ( id_user INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, profil_img TEXT , level INTEGER , coins Integer )");
        await db.execute(
            "CREATE TABLE Sub_Themes(id_sub_theme INTEGER PRIMARY KEY AUTOINCREMENT,name_sub_theme TEXT)");
        await db.execute(
            "CREATE TABLE Quiz(id_quiz INTEGER PRIMARY KEY AUTOINCREMENT,name_quiz Text ,state BOOLEAN)");
        await db.execute(
            "CREATE TABLE Progress(id INTEGER PRIMARY KEY AUTOINCREMENT,id_user INTEGER,id_sub_theme INTEGER,id_quiz INTEGER,lesson INTEGER, stars INTEGER,words INTEGER,FOREIGN KEY (id_user) REFERENCES Users(id_user),FOREIGN KEY (id_sub_theme) REFERENCES Sub_Themes(id_sub_theme),FOREIGN KEY (id_quiz) REFERENCES Quiz(id_quiz))");
      },
      version: 1,
    );
  }

  final subThemes = [
    'Loisirs',
    'Sports',
    'Forêt',
    'Ferme',
    'Cuisine',
    'Aliments',
    'Eléments',
    'Personnes',
    'Maison',
    'Famille',
    'Mon corps',
    'Mes habits',
  ];

  final quizs = ['Ecouter', 'Lire', 'Ecrire'];
/* 
  for (final subTheme in subThemes) {
  await db.insert('Sub_Themes', {'name_sub_theme': subTheme});
  } */

  Future<void> insertData_subtheme_quiz() async {
    Database db = await database;
    for (final subtheme in subThemes) {
      await db.insert('Sub_Themes', {'name_sub_theme': subtheme});
    }
    for (final quiz in quizs) {
      await db.insert('Quiz', {'name_quiz': quiz});
    }
    await db.insert('Users',
        {'name': 'nour', 'profil_img': 'jnfv', 'level': 1, 'coins': 333});
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database db = await database;
    return await db.query('Quiz');
  }

  //CRUD USER

  Future<List<User>> getUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id_user'],
        name: maps[i]['name'],
        image: maps[i]['profil_img'],
        coins: maps[i]['coins'],
        current_level: maps[i]['level'],
      );
    });
  }

  Future<void> addUser(User user) async {
    final Database db = await database;
    await db.insert('Users', user.toMap());
  }

  Future<void> updateUser(User user) async {
    final Database db = await database;
    await db.update('Users', user.toMap(),
        where: 'id_user = ?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(int id) async {
    final Database db = await database;
    await db.delete('Users', where: 'id_user = ?', whereArgs: [id]);
  }

  // Sub_Theme CRUD

  Future<List<Sub_theme>> getSubTheme() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Sub_themes');
    return List.generate(maps.length, (i) {
      return Sub_theme(
        id: maps[i]['id_sub_theme'],
        name_sub_theme: maps[i]['name_sub_theme'],
      );
    });
  }

  Future<void> addSubTheme(Sub_theme sub_theme) async {
    final Database db = await database;
    await db.insert('Sub_themes', sub_theme.toMap());
  }

  Future<void> updateSubTheme(Sub_theme sub_theme) async {
    final Database db = await database;
    await db.update('Sub_themes', sub_theme.toMap(),
        where: 'id_sub_theme = ?', whereArgs: [sub_theme.id]);
  }

  Future<void> deleteSubTheme(int id) async {
    final Database db = await database;
    await db.delete('Sub_themes', where: 'id_sub_theme = ?', whereArgs: [id]);
  }

  // QUIZ CRUD

  Future<List<Quiz>> getQuiz() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Quiz');
    return List.generate(maps.length, (i) {
      return Quiz(
        id: maps[i]['id_quiz'],
        name_quiz: maps[i]['name_quiz'],
      );
    });
  }

  Future<void> addQuiz(Quiz quiz) async {
    final Database db = await database;
    await db.insert('Quiz', quiz.toMap());
  }

  Future<void> updateQuiz(Quiz quiz) async {
    final Database db = await database;
    await db.update('Quiz', quiz.toMap(),
        where: 'id_quiz = ?', whereArgs: [quiz.id]);
  }

  Future<void> deleteQuiz(int id) async {
    final Database db = await database;
    await db.delete('Quiz', where: 'id_quiz = ?', whereArgs: [id]);
  }

  //CRUD PROGRESSION

  Future<int> getWordsPerTheme(int id_user, int id_subtheme) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT words
    FROM Progress
    WHERE id_sub_theme = $id_subtheme AND id_user = $id_user
  ''');
    if (result.isNotEmpty) {
      return result.first['words'];
    } else {
      return 0;
    }
  }

  Future<int> getWordsPerUser(int? id_user) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(words) as total_words
    FROM Progress
    WHERE id_user = $id_user
  ''');
    if (result.isNotEmpty) {
      return result.first['total_words'];
    } else {
      return 0;
    }
  }

  Future<int> getStarsPerTheme(int? id_user, int id_subtheme) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT stars
    FROM Progress
    WHERE id_sub_theme = $id_subtheme AND id_user = $id_user
  ''');
    if (result.isNotEmpty) {
      return result.first['stars'];
    } else {
      return 0;
    }
  }
}
