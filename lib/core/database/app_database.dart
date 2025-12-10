import 'package:path/path.dart';
import 'package:rick_morty_practice/core/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._();

  AppDatabase._();

  factory AppDatabase() {
    return _instance;
  }

  Database? _database;

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), DatabaseConstants.databaseName);

    return await openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onCreate: (db, version) {
        db.execute('''
        create table ${DatabaseConstants.charactersTableName} (
        id integer primary key,
        name text,
        image text,
        species text
        )
        ''');
      },
    );
  }

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database as Database;
  }
}
