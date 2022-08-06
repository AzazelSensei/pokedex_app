import 'package:flutter/material.dart';

import '../../../network/endpoint.dart';
import '../../../network/pokedex_repository.dart';
import '../model/pokedex_list_model.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'pokedex_list_state.dart';

class PokedexListCubit extends Cubit<PokedexListState> {
  PokedexListCubit(this.pokedexRepository) : super(PokedexListInitial());
  final PokedexRepository pokedexRepository;

  Future<void> getPokemonList(int limit) async {
    emit(PokedexListLoading());

    final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));

    try {
      
      final response = await dio.get(
        EndPoint.pokemonEndPoint,
        queryParameters: {"limit": limit},
      );
      //OR
      // final response = await dio.get(
      //   "https://pokeapi.co/api/v2/pokemon?limit=$limit",
      // );
      if (response.statusCode == 200) {
        final model = PokedexResult.fromJson(response.data);
        emit(PokedexListLoaded(model.results?? []));
      } else {}
    } catch (e) {
      emit(PokedexListError(e.toString()));
    }
  }
}
