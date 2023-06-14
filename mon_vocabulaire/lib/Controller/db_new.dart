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
            "CREATE TABLE Progression ( user_id INTEGER, subTheme_id INTEGER, quiz INTEGER, part INTEGER, stars INTEGER, words INTEGER, finished BOOLEAN, FOREIGN KEY (user_id) REFERENCES User(user_id) )");
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

  Future<List<User>> getUsersTop5() async {
    Database database = await initDatabase();
    List<Map<String, dynamic>> userMaps = await database.rawQuery('''
    SELECT User.*, SUM(Progression.stars) AS total_stars
    FROM User
    JOIN Progression ON User.user_id = Progression.user_id
    GROUP BY User.user_id
    ORDER BY total_stars DESC
    ''');

    List<User> users = [];
    for (var userMap in userMaps) {
      User user = User.fromMap(userMap);
      users.add(user);
    }

    return users;
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
      id: maps.first['user_id'],
      name: maps.first['name'],
      image: maps.first['profil_img'],
      coins: maps.first['coins'],
      currentLevel: maps.first['level'],
    );
  }

  Future<int> getCoins(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'User',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return maps.first['coins'];
  }

  Future<String> getImage(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'User',
      where: 'user_id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return maps.first['profil_img'];
  }

  Future<int> addUser(User user) async {
    final Database db = await database;
    int insertedId = await db.insert('User', user.toMap());
    addAllProgression(insertedId);
    return insertedId;
  }

  Future<void> updateUser(User user) async {
    final Database db = await database;
    await db.update('User', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.id]);
  }

  Future<void> editUser(int userId, String name, String image) async {
    final Database db = await database;
    await db.transaction((txn) async {
      await txn.rawUpdate(
        'UPDATE User SET name = ?, profil_img = ? WHERE user_id = ?',
        [name, image, userId],
      );
    });
  }

  Future<void> addCoins(int userId, int coins) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE User SET coins = coins + ? WHERE user_id = ?',
      [coins, userId],
    );
  }

  Future<void> substractCoins(int userId, int coins) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE User SET coins = coins - ? WHERE user_id = ?',
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
      userId: maps.first['user_id'],
      subThemeId: maps.first['subTheme_id'],
      quiz: maps.first['quiz'],
      part: maps.first['part'],
      stars: maps.first['stars'],
      mots: maps.first['words'],
    );
  }

  Future<bool> getFinished(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
      limit: 1,
    );
    if (maps.first['finished'] == 1) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> getPart(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
      limit: 1,
    );
    return maps.first['part'];
  }

  Future<int> getQuiz(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
      limit: 1,
    );
    return maps.first['quiz'];
  }

  Future<int> getAllProgression(int? userId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(words) as total
    FROM Progression
    WHERE user_id = $userId
    ''');
    if (result.isNotEmpty) {
      return result.first['total'];
    } else {
      return 0;
    }
  }

  Future<int> getStars(int? userId) async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT SUM(stars) as total
    FROM Progression
    WHERE user_id = $userId
    ''');
    if (result.isNotEmpty) {
      return result.first['total'];
    } else {
      return 0;
    }
  }

  Future<void> addProgression(Progression progression) async {
    final Database db = await database;
    await db.insert('Progression', progression.toMap());
  }

  Future<void> addAllProgression(int userId) async {
    addProgression(Progression(
        userId: userId, subThemeId: 1, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 2, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 3, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 4, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 5, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 6, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 7, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 8, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 9, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 10, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 11, quiz: 0, part: 1, stars: 0, mots: 0));
    addProgression(Progression(
        userId: userId, subThemeId: 12, quiz: 0, part: 1, stars: 0, mots: 0));
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

  Future<void> updateFinished(int userId, int subThemeId, bool finished) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE Progression SET finished = ? WHERE user_id = ? AND subTheme_id = ?',
      [finished, userId, subThemeId],
    );
  }

  Future<void> updatePart(int userId, int subThemeId, int part) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE Progression SET part = ? WHERE user_id = ? AND subTheme_id = ?',
      [part, userId, subThemeId],
    );
  }

  Future<void> updateQuiz(int userId, int subThemeId, int quiz) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE Progression SET quiz = ? WHERE user_id = ? AND subTheme_id = ?',
      [quiz, userId, subThemeId],
    );
  }

  Future<void> addWords(int userId, int words, int subThemeId) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE Progression SET words = words + ? WHERE user_id = ? AND subTheme_id = ?',
      [words, userId, subThemeId],
    );
  }

  Future<void> addStars(int userId, int subThemeId, int stars) async {
    final Database db = await database;
    await db.rawUpdate(
      'UPDATE Progression SET stars = stars + ? WHERE user_id = ? AND subTheme_id = ?',
      [stars, userId, subThemeId],
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
