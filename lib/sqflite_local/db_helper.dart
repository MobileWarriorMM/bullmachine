import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('videos.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE videos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            url TEXT NOT NULL UNIQUE,
            localPath TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertVideo(String url, String localPath) async {
    final db = await database;
    await db.insert(
      'videos',
      {'url': url, 'localPath': localPath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getVideo(String url) async {
    final db = await database;
    final result = await db.query(
      'videos',
      where: 'url = ?',
      whereArgs: [url],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}