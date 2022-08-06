part of 'pokedex_list_cubit.dart';

@immutable
abstract class PokedexListState {}

class PokedexListInitial extends PokedexListState {}

class PokedexListLoading extends PokedexListState {}

class PokedexListLoaded extends PokedexListState {
  final List<Result> pokemons;

  PokedexListLoaded(this.pokemons);
}

class PokedexListError extends PokedexListState {
  final String errorMessage;

  PokedexListError(this.errorMessage);
}
