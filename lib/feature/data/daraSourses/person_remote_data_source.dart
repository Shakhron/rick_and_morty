import 'dart:convert';

import 'package:rick_and_morty/app/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:http/http.dart' as http;

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>> getAllPersons(int page);
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl implements PersonRemoteDataSource {
  final http.Client client;

  PersonRemoteDataSourceImpl({required this.client});
  @override
  Future<List<PersonModel>> getAllPersons(int page) =>
      _getPersonFromUrl('https://rickandmortyapi.com/api/character');

  @override
  Future<List<PersonModel>> searchPerson(String query) => _getPersonFromUrl(
      'https://rickandmortyapi.com/api/character/?name=$query');

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final persons = jsonDecode(response.body);
      return (persons['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
