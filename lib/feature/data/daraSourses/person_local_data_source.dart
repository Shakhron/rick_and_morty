import 'dart:convert';

import 'package:rick_and_morty/app/error/exception.dart';
import 'package:rick_and_morty/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_PERSONS_LIST_KEY = 'CACHED_PERSONS_LIST';

abstract class PersonLocalDataSource {
  Future<List<PersonModel>> getLastPersonFromCache();
  Future<void> persontoCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getLastPersonFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST_KEY);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((e) => PersonModel.fromJson(jsonDecode(e)))
          .toList());
    } else {
      throw CacheExteption();
    }
  }

  @override
  Future<void> persontoCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((e) => jsonEncode(e.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST_KEY, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
