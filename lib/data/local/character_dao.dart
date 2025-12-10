import 'package:rick_morty_practice/core/constants/database_constants.dart';
import 'package:rick_morty_practice/core/database/app_database.dart';
import 'package:rick_morty_practice/data/local/character_entity.dart';
import 'package:rick_morty_practice/data/remote/character_dto.dart';

class CharacterDao {
  Future<void> insert(CharacterEntity character) async {
    final db = await AppDatabase().database;
    await db.insert(DatabaseConstants.charactersTableName, character.toMap());
  }

  Future<void> delete(int id) async {
    final db = await AppDatabase().database;
    await db.delete(
      DatabaseConstants.charactersTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Set<int>> getFavoriteCharactersIds() async {
    final db = await AppDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConstants.charactersTableName,
    );
    return maps.map((map) => map['id'] as int).toSet();
  }

  Future<List<CharacterDto>> getFavoriteCharacters() async {
    final db = await AppDatabase().database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseConstants.charactersTableName,
    );
    return maps.map((e) => CharacterDto.fromJson(e)).toList();
  }
}
