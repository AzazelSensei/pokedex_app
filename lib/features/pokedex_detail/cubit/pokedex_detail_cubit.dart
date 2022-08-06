import 'dart:async';

import 'package:flutter/material.dart';

import '../../../network/endpoint.dart';
import '../../../network/pokedex_repository.dart';
import '../model/pokedex_detail_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

part 'pokedex_detail_state.dart';

class PokedexDetailCubit extends Cubit<PokedexDetailState> {
  PokedexDetailCubit(this.pokedexRepository) : super(PokedexDetailInitial());
  final PokedexRepository pokedexRepository;

  Future<void> getPokemonDetail(int id) async {
    emit(PokedexDetailLoading());

    final dio = Dio(BaseOptions(baseUrl: EndPoint.baseUrl));

    try {
      final response = await dio.get(
        "https://pokeapi.co/api/v2/pokemon/$id",
      );
      // final response = await dio.get(id);
      if (response.statusCode == 200) {
        final model = PokodexDetail.fromJson(response.data);
        emit(PokedexDetailLoaded(
          model
        ));
      } else {}
    } catch (e) {
      emit(PokedexDetailError(e.toString()));
    }
  }
}

//repodaki fonksiyon kullanılacak

