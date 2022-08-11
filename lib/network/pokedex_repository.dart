// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:pokedex_app/network/endpoint.dart';

import '../features/pokedex_detail/model/pokedex_detail_model.dart';
import '../features/pokedex_list/model/pokedex_list_model.dart';

class PokedexRepository {
  final Dio dio;

  PokedexRepository(this.dio);

  Future<PokedexResult> getPokemonList(int limit) async {
    final response = await dio.get(
      EndPoint.pokemonEndPoint,
      queryParameters: {"limit": limit},
    );

    if (response.statusCode == 200) {
      return PokedexResult.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }

  Future<PokodexDetail> getPokemonDetail(int id) async {
    final response = await dio.get("${EndPoint.pokemonEndPoint}/$id");
    if (response.statusCode == 200) {
      return PokodexDetail.fromJson(response.data);
    } else {
      throw response.statusCode.toString();
    }
  }
}
