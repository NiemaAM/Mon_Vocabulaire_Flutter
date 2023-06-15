import 'package:flutter/foundation.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';

class RealtimeDataController extends ChangeNotifier {
  // DatabaseHelper instance
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  //USER
  // Get all users
  List<User> _users = [];
  List<User> get users => _users;

  Future<void> getAllUsers() async {
    _users = await _databaseHelper.getUsersTop5();
    notifyListeners();
  }

  // Get a user by ID
  User? _user;
  User? get user => _user;

  Future<void> getUser(int userId) async {
    _user = await _databaseHelper.getUser(userId);
    notifyListeners();
  }

  // Add a new user
  Future<int> addUser(User user) async {
    final insertedId = await _databaseHelper.addUser(user);
    await getAllUsers(); // Refresh user list
    return insertedId;
  }

  // Edit a user information
  Future<void> editUser(int userId, String name, String image) async {
    await _databaseHelper.editUser(userId, image, name);
    await getAllUsers(); // Refresh user list
  }

  // Add coins to a user by id
  Future<void> addCoins(int userId, int coins) async {
    await _databaseHelper.addCoins(userId, coins);
    await getAllUsers(); // Refresh user list
  }

  // Add coins to a user by id
  Future<void> substractCoins(int userId, int coins) async {
    await _databaseHelper.substractCoins(userId, coins);
    await getAllUsers(); // Refresh user list
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    await _databaseHelper.deleteUser(id);
    await getAllUsers(); // Refresh user list
  }

  //PRORESSION
  // Get all progression by user ID and subTheme ID
  List<Progression>? _allProgression;
  List<Progression>? get allProgression => _allProgression;

  Future<void> getAllProgression(int userId) async {
    _allProgression = await _databaseHelper.getAllProgression(userId);
    notifyListeners();
  }

  // Get a progression by user ID and subTheme ID
  Progression? _progression;
  Progression? get progression => _progression;

  Future<void> getProgression(int userId, int subThemeId) async {
    _progression = await _databaseHelper.getProgression(userId, subThemeId);
    notifyListeners();
  }

  //Get total words by user ID
  int? _words;
  int? get words => _words;
  Future<void> getAllWords(int userId) async {
    _words = await _databaseHelper.getAllWords(userId);
    notifyListeners();
  }

  //Get total stars by user ID
  int? _stars;
  int? get stars => _stars;
  Future<void> getAllStars(int userId) async {
    _stars = await _databaseHelper.getStars(userId);
    notifyListeners();
  }

  //Add progression to a user
  Future<void> addProgression(Progression progression) async {
    await _databaseHelper.addProgression(progression);
  }

  //Update a part in a progression by user ID and subTheme ID
  Future<void> updatePart(int userId, int subThemeId, int part) async {
    await _databaseHelper.updatePart(userId, subThemeId, part);
  }

  //Update a quiz in a progression by user ID and subTheme ID
  Future<void> updateQuiz(int userId, int subThemeId, int quiz) async {
    await _databaseHelper.updateQuiz(userId, subThemeId, quiz);
  }

  //Update a finished in a progression by user ID and subTheme ID
  Future<void> updateFinished(int userId, int subThemeId, bool finished) async {
    await _databaseHelper.updateFinished(userId, subThemeId, finished);
  }

  //Add words to a progression by user ID and subTheme ID
  Future<void> addWords(int userId, int subThemeId, int words) async {
    await _databaseHelper.addWords(userId, words, subThemeId);
  }

  //Add stars to a progression by user ID and subTheme ID
  Future<void> addStars(int userId, int subThemeId, int stars) async {
    await _databaseHelper.addStars(userId, subThemeId, stars);
  }

  //Delete a progression by user ID and subTheme ID
  Future<void> deleteProgression(int userId, int subThemeId) async {
    await _databaseHelper.deleteProgression(userId, subThemeId);
  }
}
