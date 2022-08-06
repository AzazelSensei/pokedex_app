// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';

class PokedexRepository {
  final Dio dio;

  PokedexRepository(this.dio);

  getPokemonList() async {
    final response = await dio.get('https://pokeapi.co/api/v2/pokemon');
    return response.data['results'];
  }

  getPokemonDetail(int id, bool isHidden) async {
    final response = await dio.get("https://pokeapi.co/api/v2/pokemon/$id");
    return response.data;
  }
}
