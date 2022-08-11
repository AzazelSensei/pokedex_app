import 'dart:async';
import 'package:flutter/material.dart';
import '../../../network/pokedex_repository.dart';
import '../model/pokedex_detail_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'pokedex_detail_state.dart';

class PokedexDetailCubit extends Cubit<PokedexDetailState> {
  PokedexDetailCubit(this.pokedexRepository) : super(PokedexDetailInitial());
  final PokedexRepository pokedexRepository;

  Future<void> getPokemonDetail(int id) async {
    emit(PokedexDetailLoading());

    try {
      final response = await pokedexRepository.getPokemonDetail(id);
      emit(PokedexDetailLoaded(response));
    } catch (e) {
      emit(PokedexDetailError(e.toString()));
      
    }
  }
}

//repodaki fonksiyon kullanılacak

