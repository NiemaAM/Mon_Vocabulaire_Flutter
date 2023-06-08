import '../DataBase/db.dart';
import '../Model/user.dart';

class UserController {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  UserController() {
    _databaseHelper = DatabaseHelper();
    _databaseHelper.initDatabase();
  }

  Future<List<User>> getUsers() async {
    return await _databaseHelper.getUsers();
  }

  Future<void> addUser(User user) async {
    await _databaseHelper.addUser(user);
  }

  Future<void> updateUser(User user) async {
    await _databaseHelper.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    await _databaseHelper.deleteUser(id);
  }

  Future<void> getWordsPerSubtheme(int idUser, int idSubTheme) async {
    await _databaseHelper.getWordsPerTheme(idUser, idSubTheme);
  }

  Future<int> getWordsPerUser(int? idUser) async {
    return await _databaseHelper.getWordsPerUser(idUser);
  }

  Future<int> getStarsPerUser(int idUser, int idSubtheme) {
    return _databaseHelper.getStarsPerTheme(idUser, idSubtheme);
  }
}

class SubThemeController {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  SubThemeController() {
    _databaseHelper = DatabaseHelper();
    _databaseHelper.initDatabase();
  }

  Future<List<Sub_theme>> getSubThemes() async {
    return await _databaseHelper.getSubTheme();
  }

  Future<void> addSubTheme(Sub_theme sub_theme) async {
    await _databaseHelper.addSubTheme(sub_theme);
  }

  Future<void> updateSubTheme(Sub_theme sub_theme) async {
    await _databaseHelper.updateSubTheme(sub_theme);
  }

  Future<void> deleteSubTheme(int id) async {
    await _databaseHelper.deleteSubTheme(id);
  }
}

class QuizController {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  QuizController() {
    _databaseHelper = DatabaseHelper();
    _databaseHelper.initDatabase();
  }

  Future<List<Quiz>> getQuizs() async {
    return await _databaseHelper.getQuiz();
  }

  Future<void> addQuiz(Quiz quiz) async {
    await _databaseHelper.addQuiz(quiz);
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await _databaseHelper.updateQuiz(quiz);
  }

  Future<void> deleteQuiz(int id) async {
    await _databaseHelper.deleteQuiz(id);
  }
}
