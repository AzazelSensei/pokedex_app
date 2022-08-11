import 'package:flutter/material.dart';
import '../../../network/pokedex_repository.dart';
import '../model/pokedex_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'pokedex_list_state.dart';

class PokedexListCubit extends Cubit<PokedexListState> {
  PokedexListCubit(this.pokedexRepository) : super(PokedexListInitial());
  final PokedexRepository pokedexRepository;

  Future<void> getPokemonList(int limit) async {
    emit(PokedexListLoading());

    try {
      final response = await pokedexRepository.getPokemonList(limit);
      emit(PokedexListLoaded(response.results!));
    } catch (e) {
      emit(PokedexListError(e.toString()));
    }
  }
}
