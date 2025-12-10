import 'dart:convert';
import 'dart:io';

import 'package:rick_morty_practice/core/constants/api_constants.dart';
import 'package:rick_morty_practice/data/remote/character_dto.dart';
import 'package:http/http.dart' as http;

class CharacterService {
  Future<List<CharacterDto>> searchCharacters(String query) async {
    final Uri uri = Uri.parse(ApiConstants.baseUrl).replace(
      path: ApiConstants.charactersEndpoint,
      queryParameters: {'name': query},
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == HttpStatus.ok) {
        final jsonResponse = jsonDecode(response.body);
        final List jsons = jsonResponse['results'];
        return jsons.map((json) => CharacterDto.fromJson(json)).toList();
      }

      return Future.error('Failed to load characters: ${response.statusCode}');
    } catch (e) {
      return Future.error('Failed to load characters: $e');
    }
  }
}
