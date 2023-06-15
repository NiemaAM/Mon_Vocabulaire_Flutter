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
    final Database db = await database;
    List<Map<String, dynamic>> userMaps = await db.rawQuery('''
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
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'User',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1,
      );
    });
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
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'User',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1,
      );
    });
    return maps.first['coins'];
  }

  Future<String> getImage(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'User',
        where: 'user_id = ?',
        whereArgs: [userId],
        limit: 1,
      );
    });
    return maps.first['profil_img'];
  }

  Future<int> addUser(User user) async {
    final Database db = await database;
    int insertedId = await db.insert('User', user.toMap());
    addAllProgression(insertedId);
    return insertedId;
  }

  Future updateUser(User user) async {
    final Database db = await database;
    var batch = db.batch();
    batch.update('User', user.toMap(),
        where: 'user_id = ?', whereArgs: [user.id]);
    await batch.commit(noResult: true);
  }

  Future editUser(int userId, String name, String image) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE User SET name = ?, profil_img = ? WHERE user_id = ?',
      [name, image, userId],
    );
    await batch.commit(noResult: true);
  }

  Future addCoins(int userId, int coins) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE User SET coins = coins + ? WHERE user_id = ?',
      [coins, userId],
    );
    await batch.commit(noResult: true);
  }

  Future<void> substractCoins(int userId, int coins) async {
    final Database db = await database;

    // Fetch the current user's coins
    final List<Map<String, dynamic>> result = await db.rawQuery(
      'SELECT coins FROM User WHERE user_id = ?',
      [userId],
    );

    if (result.isNotEmpty) {
      final int currentCoins = result.first['coins'];

      // Check if user has enough coins
      if (currentCoins - coins >= 0) {
        var batch = db.batch();
        batch.rawUpdate(
          'UPDATE User SET coins = coins - ? WHERE user_id = ?',
          [coins, userId],
        );
        await batch.commit(noResult: true);
      }
    }
  }

  Future deleteUser(int id) async {
    final Database db = await database;
    var batch = db.batch();
    batch.delete('User', where: 'user_id = ?', whereArgs: [id]);
    await batch.commit(noResult: true);
  }

//Progression
  Future<List<Progression>> getAllProgression(int userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query('Progression',
          where: 'user_id = ?',
          whereArgs: [userId],
          groupBy: 'subTheme_id',
          orderBy: 'subTheme_id');
    });
    return List.generate(maps.length, (i) {
      return Progression(
        userId: maps[i]['user_id'],
        subThemeId: maps[i]['subTheme_id'],
        quiz: maps[i]['quiz'],
        part: maps[i]['part'],
        stars: maps[i]['stars'],
        mots: maps[i]['words'],
      );
    });
  }

  Future<Progression> getProgression(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.transaction((txn) async {
      return await txn.query(
        'Progression',
        where: 'user_id = ? AND subTheme_id = ?',
        whereArgs: [userId, subThemeId],
        limit: 1,
      );
    });
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
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM Progression WHERE user_id = ? AND subTheme_id = ? LIMIT 1',
      [userId, subThemeId],
    );
    if (maps.isNotEmpty) {
      return maps.first['finished'] == 1;
    } else {
      return false;
    }
  }

  Future<int> getPart(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM Progression WHERE user_id = ? AND subTheme_id = ? LIMIT 1',
      [userId, subThemeId],
    );
    return maps.first['part'];
  }

  Future<int> getQuiz(int userId, int subThemeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM Progression WHERE user_id = ? AND subTheme_id = ? LIMIT 1',
      [userId, subThemeId],
    );
    return maps.first['quiz'];
  }

  Future<int> getAllWords(int? userId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
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
    final List<Map<String, dynamic>> result = await db.rawQuery('''
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

  Future addProgression(Progression progression) async {
    final Database db = await database;
    var batch = db.batch();
    batch.insert('Progression', progression.toMap());
    await batch.commit(noResult: true);
  }

  Future addAllProgression(int userId) async {
    final db = await database;
    var batch = db.batch();

    for (int i = 1; i <= 12; i++) {
      batch.insert(
          'Progression',
          Progression(
                  userId: userId,
                  subThemeId: i,
                  quiz: 0,
                  part: 1,
                  stars: 0,
                  mots: 0)
              .toMap());
    }

    await batch.commit(noResult: true);
  }

  Future updateProgression(
      int userId, int subThemeId, Progression progression) async {
    final db = await database;
    var batch = db.batch();
    batch.update(
      'Progression',
      progression.toMap(),
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future updateFinished(int userId, int subThemeId, bool finished) async {
    final db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE Progression SET finished = ? WHERE user_id = ? AND subTheme_id = ?',
      [finished, userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future updatePart(int userId, int subThemeId, int part) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE Progression SET part = ? WHERE user_id = ? AND subTheme_id = ?',
      [part, userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future updateQuiz(int userId, int subThemeId, int quiz) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE Progression SET quiz = ? WHERE user_id = ? AND subTheme_id = ?',
      [quiz, userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future addWords(int userId, int words, int subThemeId) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE Progression SET words = words + ? WHERE user_id = ? AND subTheme_id = ?',
      [words, userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future addStars(int userId, int subThemeId, int stars) async {
    final Database db = await database;
    var batch = db.batch();
    batch.rawUpdate(
      'UPDATE Progression SET stars = stars + ? WHERE user_id = ? AND subTheme_id = ?',
      [stars, userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }

  Future deleteProgression(int userId, int subThemeId) async {
    final Database db = await database;
    var batch = db.batch();
    batch.delete(
      'Progression',
      where: 'user_id = ? AND subTheme_id = ?',
      whereArgs: [userId, subThemeId],
    );
    await batch.commit(noResult: true);
  }
}
