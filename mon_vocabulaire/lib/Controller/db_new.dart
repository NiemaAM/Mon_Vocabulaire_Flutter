// ignore_for_file: depend_on_referenced_packages

import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
            "CREATE TABLE User ( user_id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, profil_img TEXT , level INTEGER , coins INTEGER )");
        await db.execute(
            "CREATE TABLE Progression ( user_id INTEGER, subTheme_id INTEGER, quiz INTEGER, part INTEGER, stars INTEGER, words INTEGER, FOREIGN KEY (user_id) REFERENCES User(user_id) )");
      },
      version: 1,
    );
  }

  //USER
  Future<List<User>> getAllUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('User');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['user_id'],
        name: maps[i]['name'],
        image: maps[i]['profil_img'],
        coins: maps[i]['coins'],
        currentLevel: maps[i]['level'],
      );
    });
  }

  Future<User> getUser(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'User',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return User(
      id: maps[0]['user_id'],
      name: maps[0]['name'],
      image: maps[0]['profil_img'],
      coins: maps[0]['coins'],
      currentLevel: maps[0]['level'],
    );
  }

  Future<void> addUser(User user) async {
    final Database db = await database;
    await db.insert('User', user.toMap());
    for (int i = 1; i == 12; i++) {
      addProgression(Progression(
          userId: user.id!,
          subThemeId: i,
          quiz: 0,
          part: 1,
          stars: 0,
          mots: 0));
    }
  }

  Future<void> updateUser(User user) async {
    final Database db = await database;
    await db.update('User', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.id]);
  }

  Future<void> addCoins(int userId, int coins) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE User SET coins = coins + ? WHERE id = ?',
      [coins, userId],
    );
  }

  Future<void> substractCoins(int userId, int coins) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE User SET coins = coins - ? WHERE id = ?',
      [coins, userId],
    );
  }

  Future<void> deleteUser(int id) async {
    final Database db = await database;
    await db.delete('User', where: 'user_id = ?', whereArgs: [id]);
  }

//Progression
  Future<Progression> getProgression(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
      limit: 1,
    );
    return Progression(
      userId: maps[0]['user_id'],
      subThemeId: maps[0]['subTheme_id'],
      quiz: maps[0]['quiz'],
      part: maps[0]['part'],
      stars: maps[0]['stars'],
      mots: maps[0]['words'],
    );
  }

  Future<int> getAllProgression(int? userId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(words) as total_words
    FROM Progression
    WHERE user_id = $userId
    ''');
    if (result.isNotEmpty) {
      return result.first['total_words'];
    } else {
      return 0;
    }
  }

/* 
  Future<int> getStarsPerSubTheme(int? userId, int subthemeId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT stars
    FROM Progression
    WHERE subTheme_id = $subthemeId AND user_id = $userId
    ''');
    if (result.isNotEmpty) {
      return result.first['stars'];
    } else {
      return 0;
    }
  }

  Future<int> getWordsPerSubTheme(int userId, int subthemeId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT words
    FROM Progression
    WHERE subTheme_id = $subthemeId AND user_id = $userId
    ''');
    if (result.isNotEmpty) {
      return result.first['words'];
    } else {
      return 0;
    }
  }
 */
  Future<void> addProgression(Progression progression) async {
    final Database db = await database;
    await db.insert('Progression', progression.toMap());
  }

  Future<void> updateProgression(
      int userId, int subThemeId, Progression progression) async {
    final Database db = await database;

    await db.update(
      'Progression',
      progression.toMap(),
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }

  Future<void> updatePart(int userId, int subThemeId, int part) async {
    final Database db = await database;

    await db.update(
      'Progression',
      {'part': part},
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }

  Future<void> updateQuiz(int userId, int subThemeId, int quiz) async {
    final Database db = await database;

    await db.update(
      'Progression',
      {'quiz': quiz},
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }

  Future<void> updateStars(int userId, int subThemeId, int stars) async {
    final Database db = await database;

    await db.update(
      'Progression',
      {'stars': stars},
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }

  Future<void> updateWords(int userId, int subThemeId, int words) async {
    final Database db = await database;

    await db.update(
      'Progression',
      {'words': words},
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }

  Future<void> deleteProgression(int userId, int subThemeId) async {
    final Database db = await database;
    await db.delete(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
  }
}
