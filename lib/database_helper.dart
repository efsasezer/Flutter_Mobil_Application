import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'example.db');

    var db = await openDatabase(
      path,
      version: 10, // Veritabanı versiyonunu artırdık
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );

    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE IF NOT EXISTS Example(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, email TEXT, password TEXT, height REAL, weight REAL, goal TEXT, weight_index INTEGER)',
    );

    await db.execute(
      'CREATE TABLE IF NOT EXISTS Exercises(id INTEGER PRIMARY KEY, name TEXT, description TEXT, calories_per_minute REAL)',
    );

    await _insertExercises(db);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
        'CREATE TABLE IF NOT EXISTS Example(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, email TEXT, password TEXT, height REAL, weight REAL, goal TEXT, weight_index INTEGER)',
      );

      await db.execute(
        'CREATE TABLE IF NOT EXISTS New_Exercises(id INTEGER PRIMARY KEY, name TEXT, description TEXT, calories_per_minute REAL)',
      );
      await db.execute(
        'INSERT INTO New_Exercises (id, name, description, calories_per_minute) SELECT id, name, description, calories_per_minute FROM Exercises',
      );
      await db.execute('DROP TABLE IF EXISTS Exercises');
      await db.execute('ALTER TABLE New_Exercises RENAME TO Exercises');
    }
  }

  Future<void> _insertExercises(Database db) async {
    Batch batch = db.batch();

    batch.insert('Exercises', {
      'name': 'Squat',
      'description':
          'Vücut ağırlığı ile yapılan en etkili egzersizlerden biri olan squat, çok yönlü bir harekettir. Kalça, karın, uyluk ve sırt kaslarının aynı anda çalışmasını sağlar.',
      'calories_per_minute': 5.0,
    });

    batch.insert('Exercises', {
      'name': 'Lunge',
      'description': '...',
      'calories_per_minute': 4.0,
    });

    batch.insert('Exercises', {
      'name': 'Push Up',
      'description': '...',
      'calories_per_minute': 6.0,
    });

    batch.insert('Exercises', {
      'name': 'Plank',
      'description': '...',
      'calories_per_minute': 3.0,
    });

    await batch.commit(noResult: true);
  }

  Future<int> insertExercise(Map<String, dynamic> row) async {
    try {
      Database? dbClient = await db;
      return await dbClient!.insert('Exercises', row);
    } catch (e) {
      print('Error inserting exercise: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllExercises() async {
    try {
      Database? dbClient = await db;
      List<Map<String, dynamic>> exerciseList = await dbClient!.query(
        'Exercises',
        columns: ['id', 'name', 'description', 'calories_per_minute'],
      );
      print('Exercise List: $exerciseList');
      return exerciseList;
    } catch (e) {
      print('Error fetching exercises: $e');
      return [];
    }
  }

  Future<int> insertData(Map<String, dynamic> row) async {
    try {
      Database? dbClient = await db;
      return await dbClient!.insert('Example', row);
    } catch (e) {
      print('Error inserting data: $e');
      return -1;
    }
  }

  Future<void> insertWeight(String email, double weight) async {
    Database? dbClient = await db;
    int maxIndex = await _getMaxWeightIndex(email);
    int newIndex = maxIndex + 1;
    await dbClient!.insert('Example', {
      'email': email,
      'weight': weight,
      'date': DateTime.now().toString(),
      'weight_index': newIndex,
    });
  }

  Future<int> updateWeight(String email, double newWeight) async {
    Database? dbClient = await db;
    int maxIndex = await _getMaxWeightIndex(email);
    int newIndex = maxIndex + 1;

    return await dbClient!.update(
      'Example',
      {
        'weight': newWeight,
        'weight_index': newIndex,
      },
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  Future<int> _getMaxWeightIndex(String email) async {
    Database? dbClient = await db;
    var result = await dbClient!.rawQuery(
      'SELECT MAX(weight_index) as max_index FROM Example WHERE email = ?',
      [email],
    );
    int maxIndex = (result.first['max_index'] ?? 0) as int;
    return maxIndex;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> users = await dbClient!.query(
      'Example',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    return users.isNotEmpty ? users.first : null;
  }

  Future<List<Map<String, dynamic>>> getAllWeightData(String userEmail) async {
    Database? dbClient = await db;
    List<Map<String, dynamic>> weightDataList = await dbClient!.query(
      'Example',
      where: 'email = ?',
      whereArgs: [userEmail],
      columns: ['weight', 'date', 'weight_index'],
      orderBy: 'weight_index ASC',
    );
    return weightDataList;
  }
}
